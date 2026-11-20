#!/bin/bash
# Builds a .deb for this machine's architecture: the binary, a menu entry and an icon.
# Needs Rust, Go and:
#   sudo apt install build-essential libgtk-3-dev libxdo-dev libayatana-appindicator3-dev \
#     libxkbcommon-dev libwayland-dev
#   packaging/linux/package-deb.sh <version> <output-dir>
set -euo pipefail

VERSION="${1:-dev}"
OUT="${2:-dist}"
mkdir -p "$OUT"
OUT="$(cd "$OUT" && pwd)"
cd "$(dirname "$0")/../.."

ARCH="$(dpkg --print-architecture)"
# Debian versions must start with a digit: v1.2.3 -> 1.2.3, anything else -> 0.0.0~<name>.
DEBVER="${VERSION#v}"
[[ "$DEBVER" =~ ^[0-9] ]] || DEBVER="0.0.0~$(echo "$VERSION" | tr -c 'A-Za-z0-9.+~\n' '.')"

cargo build --release --locked

ROOT="$OUT/build-deb-$ARCH"
rm -rf "$ROOT"
mkdir -p "$ROOT/DEBIAN" "$ROOT/usr/share/doc/tailnet-link" "$ROOT/usr/bin" "$ROOT/usr/share/applications" "$ROOT/usr/share/icons/hicolor/512x512/apps"
install -m 0755 target/release/tailnet-link "$ROOT/usr/bin/tailnet-link"
install -m 0644 LICENSE "$ROOT/usr/share/doc/tailnet-link/copyright"
install -m 0644 assets/icons/tailnet-link.png "$ROOT/usr/share/icons/hicolor/512x512/apps/tailnet-link.png"

cat > "$ROOT/usr/share/applications/tailnet-link.desktop" <<DESKTOP
[Desktop Entry]
Type=Application
Name=Tailnet Link
Comment=Reach machines on other tailnets while staying on your own
Exec=/usr/bin/tailnet-link
Icon=tailnet-link
Terminal=false
Categories=Network;
DESKTOP

cat > "$ROOT/DEBIAN/control" <<CONTROL
Package: tailnet-link
Version: $DEBVER
Architecture: $ARCH
Maintainer: Azazel Labs LLC <noreply@localhost>
Homepage: https://github.com/Azazel-Labs/tailnet-link
Section: net
Priority: optional
Depends: libgtk-3-0, libayatana-appindicator3-1 | libappindicator3-1, libxkbcommon0, libxkbcommon-x11-0, libwayland-client0, libgl1 | libvulkan1
Recommends: gnome-shell-extension-appindicator | plasma-workspace
Description: Reach machines on other tailnets while staying on your own
 A tray app that joins extra Tailscale tailnets in userspace (libtailscale)
 and routes only their domains through them, via the system proxy setting.
CONTROL

dpkg-deb --build --root-owner-group "$ROOT" "$OUT/tailnet-link-linux-$ARCH.deb" >/dev/null
cp target/release/tailnet-link "$OUT/tailnet-link-linux-$ARCH"
rm -rf "$ROOT"
echo "Built $OUT/tailnet-link-linux-$ARCH.deb ($DEBVER)"
