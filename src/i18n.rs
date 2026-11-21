//! Embedded Fluent catalogs with checked message calls and English fallback.
use i18n_embed::{
    LanguageLoader,
    fluent::{FluentLanguageLoader, fluent_language_loader},
};
use rust_embed::RustEmbed;
use std::sync::LazyLock;
mod system;

#[derive(RustEmbed)]
#[folder = "locales/"]
struct Localizations;

include!(concat!(env!("OUT_DIR"), "/translations.rs"));

pub static LOADER: LazyLock<FluentLanguageLoader> = LazyLock::new(|| {
    let loader = fluent_language_loader!();
    loader.load_languages(&Localizations, &[loader.fallback_language().clone()]).expect("embedded English catalog");
    // Every catalog is left-to-right; bidi isolation marks would only show up as stray glyphs.
    configure_numbers(&loader);
    loader
});

pub fn languages() -> impl Iterator<Item = &'static str> {
    LANGUAGES.iter().copied()
}

/// Load the catalog for `code`, or the best match for the OS languages when
/// `code` is "auto", and return the catalog actually used.
pub fn set_language(code: &str) -> &'static str {
    let preferences = if code == "auto" { system::languages() } else { vec![code.to_owned()] };
    let code = preferred_catalog(&preferences, LANGUAGES).unwrap_or("en");
    LOADER
        .load_languages(&Localizations, &[code.parse().expect("validated catalog language")])
        .expect("validated embedded Fluent catalogs");
    configure_numbers(&LOADER);
    code
}

/// Keep values numeric for plural selection, grouping integers only when displayed.
fn configure_numbers(loader: &FluentLanguageLoader) {
    loader.set_use_isolating(false);
    let language = loader.current_language().to_string();
    macro_rules! formatter {
        ($($code:literal),*) => {
            loader.with_bundles_mut(|bundle| {
                bundle.set_formatter(Some(match language.as_str() {
                    $($code => |value, _| format_number(value, $code),)*
                    _ => |value, _| format_number(value, "en"),
                }));
            });
        };
    }
    formatter!(
        "af", "ca", "cs", "da", "de", "el", "en", "es-419", "es-ES", "fi", "fr", "hu", "id", "it", "ja", "ko", "nb",
        "nl", "pl", "pt-BR", "pt-PT", "ro", "ru", "sr-Cyrl", "sv", "th", "tr", "uk", "vi", "zh-Hans", "zh-Hant"
    );
}

fn format_number(value: &fluent_bundle::FluentValue<'_>, language: &str) -> Option<String> {
    if let fluent_bundle::FluentValue::Number(number) = value
        && number.value >= 0.0
        && number.value <= 9_007_199_254_740_991.0
        && number.value.fract() == 0.0
    {
        Some(count_for_language(number.value as u64, language))
    } else {
        None
    }
}

fn count_for_language(n: u64, language: &str) -> String {
    use num_format::{Locale, ToFormattedString};
    let normalized = language.replace('-', "_");
    let locale = Locale::from_name(&normalized)
        .or_else(|_| Locale::from_name(language.split('-').next().unwrap_or("en")))
        .unwrap_or(Locale::en);
    n.to_formatted_string(&locale)
}

/// The untranslated C/POSIX locale, with or without a codeset or modifier.
fn is_c_locale(locale: &str) -> bool {
    matches!(locale.split(['.', '@']).next(), Some("C" | "POSIX"))
}

/// CLDR parents, checked after an exact match and before truncation. Explicit
/// scripts (zh-Hans-CN) retain priority through the normal truncation.
/// <https://github.com/unicode-org/cldr/blob/main/common/supplemental/supplementalData.xml>
const PARENTS: &[(&str, &[&str])] = &[
    // Region-only OS locales for Chinese.
    ("zh-Hans", &["zh-cn", "zh-sg"]),
    ("zh-Hant", &["zh-tw", "zh-hk", "zh-mo"]),
    // parentLocales: Latin American Spanish, before the generic `es` fallback.
    (
        "es-419",
        &[
            "es-ar", "es-bo", "es-br", "es-bz", "es-cl", "es-co", "es-cr", "es-cu", "es-do", "es-ec", "es-gt", "es-hn",
            "es-jp", "es-mx", "es-ni", "es-pa", "es-pe", "es-pr", "es-py", "es-sv", "es-us", "es-uy", "es-ve",
        ],
    ),
    // parentLocales: European Portuguese.
    ("pt-PT", &["pt-ao", "pt-ch", "pt-cv", "pt-fr", "pt-gq", "pt-gw", "pt-lu", "pt-mo", "pt-mz", "pt-st", "pt-tl"]),
    // Legacy macrolanguage `no` (e.g. glibc no_NO) means Bokmål in practice.
    ("nb", &["no"]),
];
/// Serbian locales whose likely script is Cyrillic, unless Latin is requested.
const SERBIAN_CYRILLIC: &[&str] = &["sr", "sr-rs", "sr-ba", "sr-xk"];

/// Match preferences in order, allowing a regional locale to use its generic
/// catalog (fr-CA -> fr), with CLDR's explicit parents above.
/// Never guess between sibling regional or script variants.
fn preferred_catalog<'a>(preferences: &[String], available: &[&'a str]) -> Option<&'a str> {
    let find = |code: &str| available.iter().copied().find(|c| c.eq_ignore_ascii_case(code));
    for preference in preferences {
        let lower = preference.to_ascii_lowercase();
        // CLDR likely subtags: Serbian is Cyrillic except in Montenegro or when
        // Latin is requested by script tag or glibc's @latin modifier.
        let serbian_latin = lower.contains("latn")
            || lower.contains("@latin")
            || lower.split(['-', '_', '.', '@']).nth(1) == Some("me");
        let code = if is_c_locale(preference) {
            "en".to_owned()
        } else {
            lower.split(['.', '@']).next().unwrap_or_default().replace('_', "-")
        };
        let mut code = code.as_str();
        loop {
            let parent = PARENTS
                .iter()
                .find(|(_, children)| children.contains(&code))
                .map(|(parent, _)| *parent)
                .or_else(|| (!serbian_latin && SERBIAN_CYRILLIC.contains(&code)).then_some("sr-Cyrl"));
            if let Some(catalog) = find(code).or_else(|| parent.and_then(find)) {
                return Some(catalog);
            }
            let Some(end) = code.rfind('-') else { break };
            code = &code[..end];
        }
    }
    None
}

// Forward raw numeric arguments so Fluent can apply locale-specific plural rules.
macro_rules! tr {
    ($id:literal $(, $name:ident = $value:expr)* $(,)?) => {
        i18n_embed_fl::fl!($crate::i18n::LOADER, $id $(, $name = $value)*)
    };
}
pub(crate) use tr;

/// Native name first, followed by the name in the active UI language.
pub fn language_name(code: &str) -> String {
    let (native, translated) = match code {
        "en" => ("English", tr!("english")),
        "fr" => ("Français", tr!("french")),
        "de" => ("Deutsch", tr!("german")),
        "es-419" => ("Español latinoamericano", tr!("spanish-latin-america")),
        "es-ES" => ("Español de España", tr!("spanish-spain")),
        "zh-Hans" => ("简体中文", tr!("chinese-simplified")),
        "zh-Hant" => ("繁體中文", tr!("chinese-traditional")),
        "ko" => ("한국어", tr!("korean")),
        "ja" => ("日本語", tr!("japanese")),
        "pl" => ("Polski", tr!("polish")),
        "ru" => ("Русский", tr!("russian")),
        "pt-BR" => ("Português do Brasil", tr!("portuguese-brazil")),
        "it" => ("Italiano", tr!("italian")),
        "tr" => ("Türkçe", tr!("turkish")),
        "uk" => ("Українська", tr!("ukrainian")),
        "cs" => ("Čeština", tr!("czech")),
        "pt-PT" => ("Português de Portugal", tr!("portuguese-portugal")),
        "nl" => ("Nederlands", tr!("dutch")),
        "id" => ("Bahasa Indonesia", tr!("indonesian")),
        "vi" => ("Tiếng Việt", tr!("vietnamese")),
        "th" => ("ไทย", tr!("thai")),
        "sv" => ("Svenska", tr!("swedish")),
        "ro" => ("Română", tr!("romanian")),
        "hu" => ("Magyar", tr!("hungarian")),
        "af" => ("Afrikaans", tr!("afrikaans")),
        "ca" => ("Català", tr!("catalan")),
        "sr-Cyrl" => ("Српски, ћирилица", tr!("serbian-cyrillic")),
        "da" => ("Dansk", tr!("danish")),
        "fi" => ("Suomi", tr!("finnish")),
        "el" => ("Ελληνικά", tr!("greek")),
        "nb" => ("Norsk bokmål", tr!("norwegian-bokmal")),
        _ => return code.to_owned(),
    };
    display_name(native, &translated)
}

/// Skip the translation when it repeats the native name ("English (English)").
fn display_name(native: &str, translated: &str) -> String {
    if translated.to_lowercase() == native.to_lowercase() {
        native.to_owned()
    } else {
        format!("{native} ({translated})")
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn loader(language: &str) -> FluentLanguageLoader {
        let loader = fluent_language_loader!();
        loader.load_languages(&Localizations, &[language.parse().expect("test locale")]).expect("embedded catalog");
        configure_numbers(&loader);
        loader
    }

    fn pick<'a>(preferences: &[&str], available: &[&'a str]) -> Option<&'a str> {
        preferred_catalog(&preferences.iter().map(|s| (*s).to_owned()).collect::<Vec<_>>(), available)
    }

    #[test]
    fn regional_os_locales_select_their_catalog() {
        for (locales, code) in [
            (&["en-US", "en-GB", "en_AU.UTF-8"][..], "en"),
            (&["fr-FR", "fr-CA", "fr-BE", "fr_CH.UTF-8"][..], "fr"),
            (&["de-DE", "de-AT", "de-CH", "de_DE.UTF-8"][..], "de"),
            (&["es-419", "es-MX", "es_AR.UTF-8", "es-CO", "es-US", "ES-cl"][..], "es-419"),
            (&["es-ES", "es_ES.UTF-8", "ES-es"][..], "es-ES"),
            (&["zh-Hans", "zh-Hans-CN", "zh-Hans-HK", "zh-CN", "zh_SG.UTF-8"][..], "zh-Hans"),
            (&["zh-Hant", "zh-Hant-CN", "zh-TW", "zh_HK.UTF-8", "zh-MO"][..], "zh-Hant"),
            (&["ko", "ko-KR", "ko_KR.UTF-8"][..], "ko"),
            (&["ja", "ja-JP", "ja_JP.UTF-8"][..], "ja"),
            (&["pl-PL", "pl_PL.UTF-8"][..], "pl"),
            (&["ru-RU", "ru-KZ", "ru_RU.UTF-8"][..], "ru"),
            (&["pt-BR", "pt_BR.UTF-8", "PT-br"][..], "pt-BR"),
            (&["pt-PT", "pt-AO", "pt-MZ", "pt_PT.UTF-8"][..], "pt-PT"),
            (&["it-IT", "it-CH"][..], "it"),
            (&["tr_TR.UTF-8"][..], "tr"),
            (&["uk-UA"][..], "uk"),
            (&["cs-CZ"][..], "cs"),
            (&["nl-BE", "nl-NL"][..], "nl"),
            (&["id-ID"][..], "id"),
            (&["vi-VN"][..], "vi"),
            (&["th-TH"][..], "th"),
            (&["sv-FI", "sv-SE"][..], "sv"),
            (&["ro-MD", "ro-RO"][..], "ro"),
            (&["hu-HU"][..], "hu"),
            (&["af-ZA"][..], "af"),
            (&["ca-ES", "ca_AD.UTF-8"][..], "ca"),
            (&["sr", "sr-Cyrl-RS", "sr_RS.UTF-8", "sr-BA"][..], "sr-Cyrl"),
            (&["da-DK"][..], "da"),
            (&["fi_FI.UTF-8"][..], "fi"),
            (&["el-GR"][..], "el"),
            (&["nb-NO", "no_NO.UTF-8"][..], "nb"),
        ] {
            for locale in locales {
                assert_eq!(pick(&[locale], LANGUAGES), Some(code), "{locale}");
            }
        }
        assert_eq!(pick(&["zh"], LANGUAGES), None);
        assert_eq!(pick(&["pt"], LANGUAGES), None);
        assert_eq!(pick(&["es-ES", "es-MX"], LANGUAGES), Some("es-ES"));
        assert_eq!(pick(&["es-MX", "es-ES"], LANGUAGES), Some("es-419"));
    }

    #[test]
    fn latin_american_spanish_matches_parents_without_overriding_exact_locales() {
        let available = ["en", "es", "es-419", "es-MX"];
        assert_eq!(pick(&["es-MX"], &available), Some("es-MX"));
        assert_eq!(pick(&["es-AR", "en"], &available), Some("es-419"));
        assert_eq!(pick(&["en", "es-AR"], &available), Some("en"));
        assert_eq!(pick(&["es-ES"], &available), Some("es"));
        assert_eq!(pick(&["es-ES", "es-GQ", "es"], &["en", "es-419"]), None);
        assert_eq!(pick(&["es-AR"], &["en", "es"]), Some("es"));
    }

    #[test]
    fn chinese_regions_map_to_scripts_but_exact_locales_win() {
        assert_eq!(pick(&["zh-CN"], &["zh-Hans", "zh-CN"]), Some("zh-CN"));
        assert_eq!(pick(&["zh-TW"], &["zh-Hant", "zh-TW"]), Some("zh-TW"));
        let preferences = ["zh-TW", "zh-SG", "en-US"];
        assert_eq!(pick(&preferences, &["zh-Hans", "zh-Hant", "en"]), Some("zh-Hant"));
        assert_eq!(pick(&preferences, &["zh-Hans", "en"]), Some("zh-Hans"));
    }

    #[test]
    fn serbian_defaults_to_cyrillic_but_never_for_latin_preferences() {
        let available = ["en", "sr-Cyrl"];
        for locale in ["sr", "sr-RS", "sr_RS.UTF-8", "sr-BA", "sr-XK", "sr-Cyrl", "sr-Cyrl-ME"] {
            assert_eq!(pick(&[locale], &available), Some("sr-Cyrl"), "{locale}");
        }
        for locale in ["sr-Latn", "sr-Latn-RS", "sr_RS@latin", "sr_RS.UTF-8@latin", "sr-ME", "sr_ME.UTF-8"] {
            assert_eq!(pick(&[locale], &available), None, "{locale}");
        }
        assert_eq!(pick(&["sr-Latn-RS", "en-US"], &available), Some("en"));
    }

    #[test]
    fn os_preferences_match_in_order_with_safe_locale_fallbacks() {
        let available = ["en", "fr", "pt-BR", "zh-Hant", "zh-Hans"];
        assert_eq!(pick(&["de-DE", "fr_CA.UTF-8", "en-US"], &available), Some("fr"));
        assert_eq!(pick(&["PT_br", "fr"], &available), Some("pt-BR"));
        assert_eq!(pick(&["zh-Hant-TW"], &available), Some("zh-Hant"));
        assert_eq!(pick(&["pt-PT"], &available), None);
        assert_eq!(pick(&["pt-AO"], &["pt-PT", "pt-AO"]), Some("pt-AO"));
        assert_eq!(pick(&["C.UTF-8"], &available), Some("en"));
        assert_eq!(pick(&["POSIX"], &available), Some("en"));
        assert_eq!(pick(&[], &available), None);
    }

    #[test]
    fn c_locale_ignores_codesets_and_modifiers() {
        for locale in ["C", "POSIX", "C.UTF-8", "C@euro", "POSIX.UTF-8"] {
            assert!(is_c_locale(locale), "{locale}");
        }
        for locale in ["", "c", "ca_ES.UTF-8", "Catalan", "en_US.UTF-8"] {
            assert!(!is_c_locale(locale), "{locale}");
        }
    }

    #[test]
    fn active_language_name_is_not_repeated() {
        assert_eq!(display_name("English", "English"), "English");
        assert_eq!(display_name("Svenska", "svenska"), "Svenska");
        assert_eq!(display_name("English", "Englisch"), "English (Englisch)");
    }

    #[test]
    fn every_catalog_has_a_display_name() {
        for &code in LANGUAGES {
            assert_ne!(language_name(code), code, "{code}: add it to language_name");
        }
    }

    #[test]
    fn english_counts_use_plural_rules_and_group_digits() {
        let en = loader("en");
        assert_eq!(i18n_embed_fl::fl!(en, "summary-routing-all", count = 2), "Routing via 2 tailnets");
        assert_eq!(
            i18n_embed_fl::fl!(en, "summary-routing-some", routing = 1, count = 3),
            "Routing via 1 of 3 tailnets"
        );
        assert_eq!(
            i18n_embed_fl::fl!(en, "machines-online", online = 1200, total = 1500),
            "Machines · 1,200 of 1,500 online"
        );
        assert_eq!(count_for_language(2_225_814, "fr"), "2\u{202f}225\u{202f}814");
        assert_eq!(count_for_language(2_225_814, "de"), "2.225.814");
    }

    /// Every catalog keeps the names, addresses and errors it's given, whatever
    /// its word order, and has actually been translated.
    #[test]
    fn every_catalog_keeps_its_arguments() {
        for &code in LANGUAGES {
            let l = loader(code);
            let cases = [
                (i18n_embed_fl::fl!(l, "hero-sign-in", tailnet = "ARG-T"), &["ARG-T"][..]),
                (i18n_embed_fl::fl!(l, "summary-routing-one", tailnet = "ARG-T"), &["ARG-T"]),
                (i18n_embed_fl::fl!(l, "summary-routing-some", routing = 1, count = 3), &["1", "3"]),
                (i18n_embed_fl::fl!(l, "tray-tailnet", tailnet = "ARG-T", state = "ARG-S"), &["ARG-T", "ARG-S"]),
                (
                    i18n_embed_fl::fl!(l, "check-ok", address = "ARG-A", tailnet = "ARG-T", ms = 7),
                    &["ARG-A", "ARG-T", "7"],
                ),
                (
                    i18n_embed_fl::fl!(
                        l,
                        "check-failed",
                        host = "ARG-H",
                        tailnet = "ARG-T",
                        port = 22,
                        error = "ARG-E"
                    ),
                    &["ARG-H", "ARG-T", "22", "ARG-E"],
                ),
                (i18n_embed_fl::fl!(l, "forward-dialog-text", host = "ARG-H"), &["ARG-H"]),
                (i18n_embed_fl::fl!(l, "remove-text", tailnet = "ARG-T"), &["ARG-T"]),
                (i18n_embed_fl::fl!(l, "machines-matching", shown = 3, total = 9), &["3", "9"]),
                (i18n_embed_fl::fl!(l, "start-failed", error = "ARG-E"), &["\nARG-E"]),
            ];
            for (text, args) in cases {
                for arg in args {
                    assert!(text.contains(arg), "{code}: {arg:?} missing from {text:?}");
                }
            }
            if code != "en" {
                for id in ["cancel", "system-default", "tab-settings", "hero-routing"] {
                    assert_ne!(l.get(id), loader("en").get(id), "{code}: {id} is untranslated");
                }
            }
        }
    }

    #[test]
    fn partial_catalog_falls_back_to_english() {
        struct Partial;
        impl i18n_embed::I18nAssets for Partial {
            fn get_files(&self, path: &str) -> Vec<std::borrow::Cow<'_, [u8]>> {
                if path == "fr/tailnet-link.ftl" {
                    vec![std::borrow::Cow::Borrowed(b"cancel = Annuler")]
                } else {
                    i18n_embed::I18nAssets::get_files(&Localizations, path)
                }
            }
            fn filenames_iter(&self) -> Box<dyn Iterator<Item = String> + '_> {
                i18n_embed::I18nAssets::filenames_iter(&Localizations)
            }
        }
        let loader = fluent_language_loader!();
        loader.load_languages(&Partial, &["fr".parse().expect("French")]).expect("partial translation");
        configure_numbers(&loader);
        assert_eq!(i18n_embed_fl::fl!(loader, "cancel"), "Annuler");
        assert_eq!(i18n_embed_fl::fl!(loader, "system-default"), "System default");
        assert_eq!(
            i18n_embed_fl::fl!(loader, "machines-online", online = 1200, total = 1500),
            "Machines · 1\u{202f}200 of 1\u{202f}500 online"
        );
    }
}
