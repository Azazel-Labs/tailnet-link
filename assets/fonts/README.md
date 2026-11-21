# Fonts

## Noto Sans Thai

Tailnet Link embeds the unmodified Noto Sans Thai Regular 2.000 font for both
egui font families, so the Thai interface and the Thai name in the language
picker render without any installed font. It adds 37,752 bytes.

- Font copyright: Copyright 2016 Google Inc. All Rights Reserved.
- License: SIL Open Font License 1.1; see [NotoSansThai-OFL.txt](NotoSansThai-OFL.txt).
- Source: https://github.com/notofonts/noto-fonts/blob/main/hinted/ttf/NotoSansThai/NotoSansThai-Regular.ttf
- License source: https://github.com/notofonts/noto-fonts/blob/main/LICENSE
- SHA-256: `404ddfb5ed0aaa6b6ec8a85700d682978992062d67da93903967b56cbd9a4acc`

## Chinese, Japanese and Korean

These fonts are over 20 MB together, more than the whole app, so they are not
bundled. `src/theme/system_fonts.rs` loads the operating system's instead:

- **Windows:** Microsoft YaHei, Microsoft JhengHei, Yu Gothic and Malgun Gothic.
- **macOS:** PingFang, Hiragino and Apple SD Gothic Neo.
- **Linux:** whatever fontconfig picks for each language, usually Noto Sans CJK.
  Systems without CJK fonts show boxes for those characters.

The UI language's regional face comes first for shared Han characters:
Traditional Chinese, Japanese and Korean put their own font first, and every
other language puts Simplified Chinese first.

## Phosphor icons

The icon font comes from the `egui-phosphor` crate (MIT).
