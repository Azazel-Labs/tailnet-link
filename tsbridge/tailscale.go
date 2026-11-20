// Copyright (c) Tailscale Inc & AUTHORS
// SPDX-License-Identifier: BSD-3-Clause

// A Go c-archive of the tsnet package. See tailscale.h for details.
// Vendored from github.com/tailscale/libtailscale (BSD-3-Clause, see LICENSE)
// at dacde75057ff. Changes for Tailnet Link: the socketpair-based
// dial/listen/accept functions moved to sockets_unix.go so the library also
// builds on Windows (sockets_windows.go stubs them). Nothing else changed.

package main

//#include "errno.h"
import "C"

import (
	"context"
	"encoding/json"
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
	"unsafe"

	"tailscale.com/hostinfo"
	"tailscale.com/ipn"
	"tailscale.com/tsnet"
	"tailscale.com/types/logger"
)

func main() {}

// servers tracks all the allocated *tsnet.Server objects.
var servers struct {
	mu   sync.Mutex
	next C.int
	m    map[C.int]*server
}

type server struct {
	s       *tsnet.Server
	lastErr string
	started bool
}

func getServer(sd C.int) *server {
	servers.mu.Lock()
	defer servers.mu.Unlock()
	return servers.m[sd]
}

func (s *server) recErr(err error) C.int {
	if err == nil {
		s.lastErr = ""
		return 0
	}
	s.lastErr = err.Error()
	return -1
}

//export TsnetNewServer
func TsnetNewServer() C.int {
	servers.mu.Lock()
	defer servers.mu.Unlock()

	if servers.m == nil {
		servers.m = map[C.int]*server{}
		hostinfo.SetApp("libtailscale")
	}
	if servers.next == 0 {
		servers.next = 42<<16 + 1
	}
	sd := servers.next
	servers.next++
	s := &server{s: &tsnet.Server{}}
	servers.m[sd] = s
	return (C.int)(sd)
}

//export TsnetStart
func TsnetStart(sd C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	err := s.s.Start()
	if err == nil {
		s.started = true
	}
	return s.recErr(err)
}

//export TsnetUp
func TsnetUp(sd C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	_, err := s.s.Up(context.Background()) // cancellation is via TsnetClose
	if err == nil {
		s.started = true
	}
	return s.recErr(err)
}

//export TsnetClose
func TsnetClose(sd C.int) C.int {
	servers.mu.Lock()
	s := servers.m[sd]
	if s != nil {
		delete(servers.m, sd)
	}
	servers.mu.Unlock()

	if s == nil {
		return C.EBADF
	}

	// TODO: cancel Up
	// TODO: close related listeners / conns.
	if !s.started {
		// Server was never started, nothing to close.
		return 0
	}
	if err := s.s.Close(); err != nil {
		s.s.Logf("tailscale_close: failed with %v", err)
		return -1
	}

	return 0
}

//export TsnetGetIps
func TsnetGetIps(sd C.int, buf *C.char, buflen C.size_t) C.int {
	if buf == nil {
		panic("errmsg passed nil buf")
	} else if buflen == 0 {
		panic("errmsg passed buflen of 0")
	}

	servers.mu.Lock()
	s := servers.m[sd]
	servers.mu.Unlock()

	out := unsafe.Slice((*byte)(unsafe.Pointer(buf)), buflen)

	if s == nil {
		out[0] = '\x00'
		return C.EBADF
	}

	ip4, ip6 := s.s.TailscaleIPs()
	joined := strings.Join([]string{ip4.String(), ip6.String()}, ",")
	n := copy(out, joined)
	if n >= len(out) {
		out[len(out)-1] = '\x00' // always NUL-terminate
		return C.ERANGE
	}
	out[n] = '\x00'
	return 0
}

//export TsnetErrmsg
func TsnetErrmsg(sd C.int, buf *C.char, buflen C.size_t) C.int {
	if buf == nil {
		panic("errmsg passed nil buf")
	} else if buflen == 0 {
		panic("errmsg passed buflen of 0")
	}

	servers.mu.Lock()
	s := servers.m[sd]
	servers.mu.Unlock()

	out := unsafe.Slice((*byte)(unsafe.Pointer(buf)), buflen)
	if s == nil {
		out[0] = '\x00'
		return C.EBADF
	}
	n := copy(out, s.lastErr)
	if n >= len(out) {
		out[len(out)-1] = '\x00' // always NUL-terminate
		return C.ERANGE
	}
	out[n] = '\x00'
	return 0
}

//export TsnetSetDir
func TsnetSetDir(sd C.int, str *C.char) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	s.s.Dir = C.GoString(str)
	return 0
}

//export TsnetSetHostname
func TsnetSetHostname(sd C.int, str *C.char) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	s.s.Hostname = C.GoString(str)
	return 0
}

//export TsnetSetAuthKey
func TsnetSetAuthKey(sd C.int, str *C.char) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	s.s.AuthKey = C.GoString(str)
	return 0
}

//export TsnetSetControlURL
func TsnetSetControlURL(sd C.int, str *C.char) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	s.s.ControlURL = C.GoString(str)
	return 0
}

//export TsnetSetEphemeral
func TsnetSetEphemeral(sd C.int, e int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	if e == 0 {
		s.s.Ephemeral = false
	} else {
		s.s.Ephemeral = true
	}
	return 0
}

//export TsnetSetLogFD
func TsnetSetLogFD(sd, fd C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	if fd == -1 {
		s.s.Logf = logger.Discard
		return 0
	}
	f := os.NewFile(uintptr(fd), "logfd")
	s.s.Logf = func(format string, args ...any) {
		fmt.Fprintf(f, format, args...)
		fmt.Fprintf(f, "\n")
	}
	return 0
}

//export TsnetLoopback
func TsnetLoopback(sd C.int, addrOut *C.char, addrLen C.size_t, proxyOut *C.char, localOut *C.char) C.int {
	// Panic here to ensure we always leave the out values NUL-terminated.
	if addrOut == nil {
		panic("loopback_api passed nil addr_out")
	} else if addrLen == 0 {
		panic("loopback_api passed addrlen of 0")
	} else if proxyOut == nil {
		panic("loopback_api passed nil proxy_cred_out")
	} else if localOut == nil {
		panic("loopback_api passed nil local_api_cred_out")
	}

	// Start out NUL-termianted to cover error conditions.
	*addrOut = '\x00'
	*localOut = '\x00'
	*proxyOut = '\x00'

	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	addr, proxyCred, localAPICred, err := s.s.Loopback()
	if err != nil {
		return s.recErr(err)
	}
	if len(proxyCred) != 32 {
		return s.recErr(fmt.Errorf("libtailscale: len(proxyCred)=%d, want 32", len(proxyCred)))
	}
	if len(localAPICred) != 32 {
		return s.recErr(fmt.Errorf("libtailscale: len(localAPICred)=%d, want 32", len(localAPICred)))
	}

	out := unsafe.Slice((*byte)(unsafe.Pointer(addrOut)), addrLen)
	n := copy(out, addr)
	if n >= len(out) {
		out[len(out)-1] = '\x00' // always NUL-terminate
		return C.ERANGE
	}
	out[n] = '\x00'

	// proxyOut and localOut are non-nil and 33 bytes long because
	// they are defined in C as char cred_out[static 33].
	out = unsafe.Slice((*byte)(unsafe.Pointer(proxyOut)), 33)
	copy(out, proxyCred)
	out[32] = '\x00'
	out = unsafe.Slice((*byte)(unsafe.Pointer(localOut)), 33)
	copy(out, localAPICred)
	out[32] = '\x00'

	return 0
}

//export TsnetStatusJSON
func TsnetStatusJSON(sd C.int, jsonOut **C.char) C.int {
	if jsonOut == nil {
		panic("status_json passed nil json_out")
	}
	*jsonOut = nil
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	// LocalClient rides tsnet's in-memory LocalAPI listener — unlike
	// Loopback()'s TCP listener it cannot be reclaimed by the OS while
	// the process is suspended (iOS), so status reads keep working on
	// long-lived nodes.
	lc, err := s.s.LocalClient()
	if err != nil {
		return s.recErr(err)
	}
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	st, err := lc.Status(ctx)
	if err != nil {
		return s.recErr(err)
	}
	b, err := json.Marshal(st)
	if err != nil {
		return s.recErr(err)
	}
	*jsonOut = C.CString(string(b))
	return 0
}

//export TsnetEnableFunnelToLocalhostPlaintextHttp1
func TsnetEnableFunnelToLocalhostPlaintextHttp1(sd C.int, localhostPort C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}

	ctx := context.Background()
	lc, err := s.s.LocalClient()
	if err != nil {
		return s.recErr(err)
	}

	st, err := lc.StatusWithoutPeers(ctx)
	if err != nil {
		return s.recErr(err)
	}
	domain := st.CertDomains[0]

	hp := ipn.HostPort(net.JoinHostPort(domain, strconv.Itoa(443)))
	tcpForward := fmt.Sprintf("127.0.0.1:%d", localhostPort)
	sc := &ipn.ServeConfig{
		TCP: map[uint16]*ipn.TCPPortHandler{
			443: {
				TCPForward:   tcpForward,
				TerminateTLS: domain,
			},
		},
		AllowFunnel: map[ipn.HostPort]bool{
			hp: true,
		},
	}

	lc.SetServeConfig(ctx, sc)
	if !sc.AllowFunnel[hp] {
		return s.recErr(fmt.Errorf("libtailscale: failed to enable funnel"))
	}

	return 0
}
