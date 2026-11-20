// SPDX-License-Identifier: BSD-3-Clause

//go:build windows

// Windows has no socketpairs or file-descriptor passing, so libtailscale's
// dial/listen/accept aren't available there. Use tailscale_loopback (a SOCKS5
// proxy and the LocalAPI over TCP) instead; that's what Tailnet Link uses on
// every platform.

package main

//#include "errno.h"
import "C"

import "errors"

var errNoSockets = errors.New("libtailscale: dial/listen/accept aren't supported on Windows; use tailscale_loopback")

//export TsnetListen
func TsnetListen(sd C.int, network, addr *C.char, listenerOut *C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	return s.recErr(errNoSockets)
}

//export TsnetAccept
func TsnetAccept(listenerFd C.int, connOut *C.int) C.int { return C.EBADF }

//export TsnetGetRemoteAddr
func TsnetGetRemoteAddr(listener C.int, conn C.int, buf *C.char, buflen C.size_t) C.int {
	return C.EBADF
}

//export TsnetDial
func TsnetDial(sd C.int, network, addr *C.char, connOut *C.int) C.int {
	s := getServer(sd)
	if s == nil {
		return C.EBADF
	}
	return s.recErr(errNoSockets)
}
