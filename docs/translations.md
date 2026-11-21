# Translating Tailnet Link

Translations live in Git and are reviewed in pull requests. No translation
service or API token is needed.

The English sources are `locales/en/tailnet-link.ftl` and `README.md`. Each
locale directory must contain every English message (including attributes),
with valid Fluent syntax and no unknown message IDs or runtime arguments. Each
locale also needs `docs/i18n/README.<locale>.md`. These localized READMEs give
the overview, features, download and installation, and contribution links; the
detailed sections stay in English.

## Conventions

- Keep **Tailnet Link**, **Tailscale**, **MagicDNS**, **PAC** and **SOCKS5** as
  they are. Treat **tailnet** as Tailscale's own word: keep it, inflected as
  your language needs, unless Tailscale's localized material uses another one.
- Name operating-system features the way the OS does in your language, for
  example Windows **Remote Desktop**, and Firefox's **Use system proxy
  settings** as Firefox shows it.
- Keep the syntax in the port forward help literal: `LOCALPORT`, `auto` and
  `host:port`.
- Every `{ $variable }` must stay a variable. A translation may leave one out
  when the sentence doesn't need it, but must never add a new one.
- Use your language's plural categories in `{ $count -> … }` selectors.
- Numbers are formatted for the active language. Ports are passed as text, so
  they are never grouped.

## Workflow

After changing English text, update each affected translation. The check
reports exact message IDs with their previous and current English text. Review
only the strings you have checked, for each locale:

```sh
cargo xtask translations fmt
cargo xtask translations check
cargo xtask translations review fr hero-routing
cargo xtask translations review fr pause-all resume
cargo xtask translations check
```

Commit the catalogs and `localization/reviewed/<locale>.toml` files together.
These files store the reviewed English and translated text for each message
value and attribute. Changing one string invalidates only that string in each
locale. Changing a translation invalidates only its review in that locale.
Plural variants belong to their containing string. Referenced messages and
terms are included transitively, so changes also invalidate strings that use
them. Comments, entry order, Fluent formatting and line endings do not
invalidate reviews. Meaningful literal whitespace still does.

If an existing translation is still correct, review that ID without making an
artificial text change. New strings need translations and reviews in every
locale. Removed IDs are reported too; review those IDs to remove their obsolete
records. Reviewing selected IDs leaves all other pending reviews untouched.

README reviews are separate, using whole-file SHA-256 fingerprints of the
English and localized README. After checking the localized README, run:

```sh
cargo xtask translations review fr --readme
```

This does not accept changed UI strings. README wording or link changes need a
README review; line-ending changes alone do not. To start a new locale, or after
explicitly reviewing its entire catalog and README, use
`cargo xtask translations review fr --all`. Calling `review fr` without IDs or
a flag fails, so it can't silently approve a whole locale.

`cargo xtask translations check` fails on missing, empty or stale files and runs
in CI. Review records show which revision was acknowledged, not that the
wording is right. Reviewers still need to read the translation, especially any
machine-assisted wording.

The first translations of the interface and README were machine-assisted. They
were checked for Fluent syntax, coverage, runtime variables and literal syntax.
Corrections from native speakers are very welcome.

## Screenshots in another language

```sh
cargo xtask screenshots --language fr
```

This writes `docs/images/<view>.fr.png`, using the same made-up tailnets as the
English screenshots.

## Adding a language

Add a complete Fluent catalog and a localized README, add its native-language
link to the README navigation, give it a name in `language_name` in
`src/i18n.rs` (and a `language-…` message in every catalog), and record its
review. The language list in Settings is generated from the locale directories.
If the language's script isn't covered by egui's fonts or the usual system
fonts, see `src/theme/system_fonts.rs`.
