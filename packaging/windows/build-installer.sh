#!/bin/bash
# Builds tailnet-link.exe (x64; ARM64 Windows runs it via its built-in x64
# emulation) and the installer. Runs on Linux with Rust, Go, MinGW and NSIS:
#   rustup target add x86_64-pc-windows-gnu
#   sudo apt install nsis gcc-mingw-w64-x86-64
#   packaging/windows/build-installer.sh <version> <output-dir>
# Also runs on Windows from Git Bash (MinGW and NSIS on PATH).
set -euo pipefail

VERSION="${1:-dev}"
OUT="${2:-dist}"
mkdir -p "$OUT"
# pwd -W gives a C:/ path under Git Bash on Windows, which makensis needs.
OUT="$(cd "$OUT" && (pwd -W 2>/dev/null || pwd))"
cd "$(dirname "$0")/../.."

# Windows needs a numeric a.b.c.d version for the file properties.
NUM="${VERSION#v}"
if [[ "$NUM" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+) ]]; then
  VERSION_NUM="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${BASH_REMATCH[3]}.0"
else
  VERSION_NUM="0.0.0.0"
fi

cargo build --release --locked --target x86_64-pc-windows-gnu
cp target/x86_64-pc-windows-gnu/release/tailnet-link.exe "$OUT/tailnet-link.exe"
cp target/x86_64-pc-windows-gnu/release/tl.exe "$OUT/tl.exe"
cp assets/icons/tailnet-link.ico "$OUT/tailnet-link.ico"
cp LICENSE "$OUT/LICENSE.txt"

# The script is UTF-8 without a BOM; makensis on Windows would read it as ANSI.
makensis -INPUTCHARSET UTF8 -V2 \
  -DVERSION="$VERSION" \
  -DVERSION_NUM="$VERSION_NUM" \
  -DDIST="$OUT" \
  -DOUTFILE="$OUT/tailnet-link-windows-setup.exe" \
  packaging/windows/tailnet-link.nsi

mv "$OUT/tailnet-link.exe" "$OUT/tailnet-link-windows-amd64.exe"
rm -f "$OUT/tl.exe" "$OUT/tailnet-link.ico" "$OUT/LICENSE.txt"
echo "Built $OUT/tailnet-link-windows-setup.exe ($VERSION)"
