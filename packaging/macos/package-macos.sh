#!/bin/bash
# Builds a universal (Apple Silicon + Intel) Tailnet Link.app, packaged as a
# drag-to-Applications .dmg and as a .zip. Run on macOS with Rust and Go:
#   rustup target add aarch64-apple-darwin x86_64-apple-darwin
#   packaging/macos/package-macos.sh <version> <output-dir>
set -euo pipefail

VERSION="${1:-dev}"
OUT="${2:-dist}"
mkdir -p "$OUT"
OUT="$(cd "$OUT" && pwd)"
cd "$(dirname "$0")/../.."

for T in aarch64-apple-darwin x86_64-apple-darwin; do
  cargo build --release --locked --target "$T"
done

APP="$OUT/Tailnet Link.app"
rm -rf "$APP" "$OUT/build"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources" "$OUT/build"
lipo -create -output "$APP/Contents/MacOS/tailnet-link" \
  target/aarch64-apple-darwin/release/tailnet-link target/x86_64-apple-darwin/release/tailnet-link
# tl, the terminal helper: the app's Open terminal button runs it from here, and
# the README shows how to link it into /usr/local/bin.
lipo -create -output "$APP/Contents/MacOS/tl" \
  target/aarch64-apple-darwin/release/tl target/x86_64-apple-darwin/release/tl

# App icon from assets/icons/tailnet-link.png.
ICONSET="$OUT/build/tailnet-link.iconset"
mkdir -p "$ICONSET"
for SZ in 16 32 128 256; do
  sips -z $SZ $SZ assets/icons/tailnet-link.png --out "$ICONSET/icon_${SZ}x${SZ}.png" >/dev/null
  DOUBLE=$((SZ * 2))
  if [ "$DOUBLE" -le 512 ]; then
    sips -z $DOUBLE $DOUBLE assets/icons/tailnet-link.png --out "$ICONSET/icon_${SZ}x${SZ}@2x.png" >/dev/null
  fi
done
iconutil -c icns "$ICONSET" -o "$APP/Contents/Resources/tailnet-link.icns"

# Plain version number for the bundle (v1.2.3 -> 1.2.3; anything else -> 0.0.0).
SHORT="${VERSION#v}"
[[ "$SHORT" =~ ^[0-9]+(\.[0-9]+){0,2}$ ]] || SHORT="0.0.0"

# LSUIElement: menu-bar app, no Dock icon.
cat > "$APP/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key><string>Tailnet Link</string>
  <key>CFBundleDisplayName</key><string>Tailnet Link</string>
  <key>CFBundleIdentifier</key><string>com.azazellabs.tailnet-link</string>
  <key>CFBundleExecutable</key><string>tailnet-link</string>
  <key>CFBundleIconFile</key><string>tailnet-link</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>$SHORT</string>
  <key>CFBundleVersion</key><string>$SHORT</string>
  <key>LSMinimumSystemVersion</key><string>11.0</string>
  <key>LSUIElement</key><true/>
  <key>NSHighResolutionCapable</key><true/>
  <key>NSHumanReadableCopyright</key><string>Copyright © 2026 Azazel Labs LLC</string>
</dict>
</plist>
EOF

# Ad-hoc signature so Apple Silicon will run it (not notarized: first launch
# needs right-click -> Open, or System Settings -> Privacy & Security -> Open Anyway).
codesign --force --deep --sign - "$APP"

ditto -c -k --keepParent "$APP" "$OUT/tailnet-link-macos-universal.zip"

STAGE="$OUT/build/dmg"
mkdir -p "$STAGE"
cp -R "$APP" "$STAGE/"
ln -s /Applications "$STAGE/Applications"
cp LICENSE "$STAGE/LICENSE.txt"
# hdiutil's own guess at the image size from -srcfolder is sometimes too small on CI runners ("No space left on
# device"), so give it one: the staged size plus room for the file system. It also fails now and then with
# "Resource busy", so try a few times.
mb=$(( $(du -sm "$STAGE" | cut -f1) * 5 / 4 + 16 ))
for try in 1 2 3; do
  if hdiutil create -volname "Tailnet Link" -srcfolder "$STAGE" -fs HFS+ -size "${mb}m" -ov -format UDZO \
    "$OUT/tailnet-link-macos-universal.dmg" >/dev/null; then
    break
  fi
  [ "$try" = 3 ] && exit 1
  echo "hdiutil failed, trying again" >&2
  sleep 5
done

rm -rf "$OUT/build" "$APP"
echo "Built $OUT/tailnet-link-macos-universal.dmg and .zip"
