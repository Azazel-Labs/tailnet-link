// Copyright (c) Tailscale Inc & AUTHORS
// SPDX-License-Identifier: BSD-3-Clause

//go:build !windows

// Unchanged libtailscale code, moved here from tailscale.go because it relies
// on Unix socketpairs and file-descriptor passing.

package main

//#include "errno.h"
import "C"

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"net"
	"os"
	"regexp"
	"sync"
	"syscall"
	"unsafe"

	"golang.org/x/sys/unix"
	"tailscale.com/tsnet"
)

// listeners tracks all the tsnet_listener objects allocated via tsnet_listen.
var listeners struct {
	mu sync.Mutex
	m  map[C.int]*listener
}

type listener struct {
	s  *server
	ln net.Listener
	fd int // go side fd of socketpair sent to C
	mu sync.Mutex
	// m maps the fd number C holds for an accepted connection (not our
	// sender-side number; recvmsg installs a new one) to its remote IP.
	m map[C.int]string
}

// listenAddrLen is the size of the fixed-size, NUL-padded record that
// carries each accepted connection's remote IP over the listener
// socketpair. Fixed size so TsnetAccept frames the stream with
// exact-size reads; 45 bytes covers the longest textual IP.
const listenAddrLen = 64

// conns tracks all the pipe(2)s allocated via tsnet_dial.
var conns struct {
	mu sync.Mutex
	m  map[C.int]*conn // keyed by the FD given to C (w)
}

type conn struct {
	s *tsnet.Server
	c net.Conn
	r *os.File // r is the local socket to the C client
}

//export TsnetListen
func TsnetListen(sd C.int, network, addr *C.char, listenerOut *C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}

	ln, err := s.s.Listen(C.GoString(network), C.GoString(addr))
	if err != nil {
		return s.recErr(err)
	}
	s.started = true

	// The tailscale_listener we return to C is one side of a socketpair(2).
	// We do this so we can proactively call ln.Accept in a goroutine and
	// feed an fd for the connection through the listener. This lets C use
	// epoll on the tailscale_listener to know if it should call
	// tailscale_accept, which avoids a blocking call on the far side.
	// Both ends are close-on-exec, so spawned processes do not inherit
	// them.
	fds, err := socketpair()
	if err != nil {
		return s.recErr(err)
	}
	sp := fds[1]
	fdC := C.int(fds[0])

	listeners.mu.Lock()
	if listeners.m == nil {
		listeners.m = map[C.int]*listener{}
	}
	listener := &listener{s: s, ln: ln, fd: sp, m: map[C.int]string{}}
	listeners.m[fdC] = listener
	listeners.mu.Unlock()

	cleanup := func() {
		// If fdC is closed on the C side, then we end up calling
		// into cleanup twice. Be careful to avoid syscall.Close
		// twice as the FD may have been reallocated.
		listeners.mu.Lock()
		if tsLn, ok := listeners.m[fdC]; ok && tsLn.ln == ln {
			delete(listeners.m, fdC)
			syscall.Close(sp)
		}
		listeners.mu.Unlock()

		ln.Close()
	}
	go func() {
		// fdC is never written to, so trying to read from sp blocks
		// until fdC is closed. We use this as a signal that C is
		// done with the listener, and we can tear it down.
		//
		// TODO: would using os.NewFile avoid a locked up thread?
		var buf [256]byte
		syscall.Read(sp, buf[:])
		cleanup()
	}()
	go func() {
		defer cleanup()
		for {
			netConn, err := ln.Accept()
			if err != nil {
				return
			}
			var connFd C.int
			if err := newConn(s, netConn, &connFd); err != nil {
				if s.s.Logf != nil {
					s.s.Logf("libtailscale.accept: newConn: %v", err)
				}
				netConn.Close()
				continue
			}
			ip := extractIP(netConn.RemoteAddr().String())
			if len(ip) >= listenAddrLen {
				if s.s.Logf != nil {
					s.s.Logf("libtailscale.accept: remote address %q does not fit in a %d-byte record", ip, listenAddrLen)
				}
				netConn.Close()
				syscall.Close(int(connFd))
				continue
			}
			var addrRec [listenAddrLen]byte
			copy(addrRec[:], ip)

			rights := syscall.UnixRights(int(connFd))
			err = syscall.Sendmsg(sp, addrRec[:], rights, nil, 0)
			if err != nil {
				// a failed sendmsg delivered nothing (sp being closed is
				// handled by the read goroutine above)
				if s.s.Logf != nil {
					s.s.Logf("libtailscale.accept: sendmsg failed: %v", err)
				}
				netConn.Close()
			}

			syscall.Close(int(connFd)) // now owned by recvmsg
		}
	}()

	*listenerOut = fdC
	return 0
}

//export TsnetAccept
func TsnetAccept(listenerFd C.int, connOut *C.int) C.int {
	listeners.mu.Lock()
	ln := listeners.m[listenerFd]
	listeners.mu.Unlock()

	if ln == nil {
		return C.EBADF
	}

	// One record per connection: the fd via SCM_RIGHTS plus its remote
	// IP. The fd parsed below is the number the kernel installed, i.e.
	// the number C will hold, and it is close-on-exec (via recvFlags on
	// Linux, or the closeOnExec call below elsewhere).
	//
	// The socketpair is a stream socket, so records are framed here:
	// each read asks for the remaining bytes of the head record, with
	// MSG_WAITALL. The FIFO never serves a later record's bytes first,
	// so each accept consumes exactly one record, even concurrently or
	// after EINTR.
	data := make([]byte, listenAddrLen)
	cbuf := make([]byte, unix.CmsgLen(int(unsafe.Sizeof((C.int)(0)))))
	var n, oobn int
	for n < len(data) {
		buf := data[n:]
		if n > 0 {
			// the cmsg rode with the record's first byte; only the tail remains
			cbuf = nil
		}
		nn, on, _, _, err := syscall.Recvmsg(int(listenerFd), buf, cbuf, recvFlags)
		n += nn
		if nn > 0 {
			oobn = on
		}
		if err == syscall.EINTR {
			continue // partial bytes stay record-aligned, keep draining
		}
		if err != nil {
			return ln.s.recErr(err)
		}
		if nn == 0 {
			// EOF mid-record: the listener was closed on the C side.
			return ln.s.recErr(fmt.Errorf("libtailscale: listener closed mid-record: got %d of %d bytes", n, len(data)))
		}
	}

	scms, err := syscall.ParseSocketControlMessage(cbuf[:oobn])
	if err != nil {
		return ln.s.recErr(err)
	}
	if len(scms) != 1 {
		return ln.s.recErr(fmt.Errorf("libtailscale: got %d control messages, want 1", len(scms)))
	}
	fds, err := syscall.ParseUnixRights(&scms[0])
	if err != nil {
		return ln.s.recErr(err)
	}
	if len(fds) != 1 {
		return ln.s.recErr(fmt.Errorf("libtailscale: got %d FDs, want 1", len(fds)))
	}
	fd := C.int(fds[0])
	closeOnExec(int(fd))

	// the entry must exist before C can learn this fd number
	addrLen := bytes.IndexByte(data, 0)
	if addrLen < 0 {
		addrLen = listenAddrLen
	}
	ln.mu.Lock()
	ln.m[fd] = string(data[:addrLen])
	ln.mu.Unlock()

	*connOut = fd

	return 0
}

func newConn(s *server, netConn net.Conn, connOut *C.int) error {
	fds, err := socketpair()
	if err != nil {
		return err
	}
	r := os.NewFile(uintptr(fds[1]), "socketpair-r")
	c := &conn{s: s.s, c: netConn, r: r}
	fdC := C.int(fds[0])

	conns.mu.Lock()
	if conns.m == nil {
		conns.m = make(map[C.int]*conn)
	}
	conns.m[fdC] = c
	conns.mu.Unlock()

	connCleanup := func() {
		var inCleanup bool
		conns.mu.Lock()
		if tsConn, ok := conns.m[fdC]; ok && tsConn.c == netConn {
			delete(conns.m, fdC)
			inCleanup = true
		}
		conns.mu.Unlock()

		if !inCleanup {
			return
		}

		r.Close()
		netConn.Close()
	}
	// the Shutdowns below must precede connCleanup: r.Fd() after Close
	// can return a reused fd number. Wait for both copy directions.
	var copies sync.WaitGroup
	copies.Add(2)
	go func() {
		defer copies.Done()
		var b [1 << 16]byte
		io.CopyBuffer(r, netConn, b[:])
		syscall.Shutdown(int(r.Fd()), syscall.SHUT_WR)
		if cr, ok := netConn.(interface{ CloseRead() error }); ok {
			cr.CloseRead()
		}
	}()
	go func() {
		defer copies.Done()
		var b [1 << 16]byte
		io.CopyBuffer(netConn, r, b[:])
		syscall.Shutdown(int(r.Fd()), syscall.SHUT_RD)
		if cw, ok := netConn.(interface{ CloseWrite() error }); ok {
			cw.CloseWrite()
		}
	}()
	go func() {
		copies.Wait()
		connCleanup()
	}()

	*connOut = fdC
	return nil
}

//export TsnetGetRemoteAddr
func TsnetGetRemoteAddr(listener C.int, conn C.int, buf *C.char, buflen C.size_t) C.int {
	if buf == nil {
		panic("errmsg passed nil buf")
	} else if buflen == 0 {
		panic("errmsg passed buflen of 0")
	}
	out := unsafe.Slice((*byte)(unsafe.Pointer(buf)), buflen)

	listeners.mu.Lock()
	defer listeners.mu.Unlock()
	l := listeners.m[listener]
	if l == nil {
		out[0] = '\x00'
		return C.EBADF
	}

	l.mu.Lock()
	defer l.mu.Unlock()
	ip, ok := l.m[conn]
	if !ok {
		// set errmsg too: EBADF with an empty message is not debuggable
		l.s.lastErr = fmt.Sprintf("libtailscale: getremoteaddr: no remote address recorded for conn %d on listener %d", conn, listener)
		out[0] = '\x00'
		return C.EBADF
	}

	n := copy(out, ip)
	if n >= len(out) {
		out[len(out)-1] = '\x00' // always NUL-terminate
		return C.ERANGE
	}
	out[n] = '\x00'
	return 0
}

// Strips the port from connection IPs
func extractIP(ipWithPort string) string {
	re := regexp.MustCompile(`(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})|\[([0-9a-fA-F:]+)\]`)
	match := re.FindString(ipWithPort)
	return match
}

//export TsnetDial
func TsnetDial(sd C.int, network, addr *C.char, connOut *C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	netConn, err := s.s.Dial(context.Background(), C.GoString(network), C.GoString(addr))
	if err != nil {
		return s.recErr(err)
	}
	s.started = true
	if err := newConn(s, netConn, connOut); err != nil {
		return s.recErr(err)
	}
	return 0
}
