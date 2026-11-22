# Releasing Tailnet Link

Release tooling is Rust: `cargo xtask`. You need Rust and Git, with push access to
the repository. VS Code provides the same commands under **Tasks: Run Task →
Tailnet Link: Release …**.

## Release from commit messages

After CI passes on a push to `main`, the
[Auto release workflow](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/auto-release.yml)
reads the commit messages:

| Tag in a commit message | Effect |
| --- | --- |
| `#release` | Tags the next version, which starts the Release workflow below. Counts commits since the last version tag. |
| `#patch`, `#minor`, `#major` | How far that release moves the version from the last tag; the largest wins, and patch when none says. On its own it does nothing: it waits for a `#release`. |

Put tags on a line of their own, alone or together, usually the last line of the
message. A tag inside a sentence is ignored, so describing these tags in a commit
message is safe.

A `#minor #release` line releases 1.0.0 to 1.1.0. Leave out `#release` to let changes
collect; the bump lines count once a later push releases.

Nothing is committed anywhere: the tag goes on your commit on `main`, and each
release build writes the tag's version into Cargo.toml and Cargo.lock before it
builds. So there's never a bot commit to pull, no bot branch off `main`, and the
bot isn't listed as a contributor. `main`'s Cargo.toml keeps the version it was
last given by hand; the version tags are what count. If CI fails, nothing happens;
the tags still count once a later push passes CI.

## Publish a version manually

Start on `main`, with everything you intend to release committed and pushed. For
example, to release `0.4.0`:

```sh
cargo xtask release publish 0.4.0
```

Publish requires a clean `main` at the same commit as `origin/main`, creates an
annotated `v0.4.0` tag, and pushes that tag. It never force-pushes or replaces a
version tag. You don't need to set the version in Cargo.toml first; the builds do.
If you want `main` to show it too, `cargo xtask release prepare 0.4.0` updates the
workspace version and the lockfile without upgrading third-party dependencies.

Follow the [Release workflow](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/release.yml).
It writes the tag's version into Cargo.toml, runs the full CI (formatting, strict
Clippy, tests and the Windows smoke test), then builds:

| Job | Output |
| --- | --- |
| Windows (cross-compiled on Linux with MinGW, NSIS installer) | `tailnet-link-windows-setup.exe`, `tailnet-link-windows-amd64.exe` |
| Linux (Ubuntu 24.04) | `tailnet-link-linux-amd64.deb`, `tailnet-link-linux-amd64` |
| macOS (universal Apple Silicon + Intel) | `tailnet-link-macos-universal.dmg`, `tailnet-link-macos-universal.zip` |

Publication waits for every build to succeed and includes `SHA256SUMS.txt` and
automatically generated release notes.

## Stable and preview versions

| Version | Result | GitHub Latest |
| --- | --- | --- |
| `0.4.0` → `v0.4.0` | Stable release | Promoted to Latest |
| `0.5.0-alpha.1`, `0.5.0-beta.1`, `0.5.0-rc.1` | Prerelease | Unchanged |

Promoting a preview to stable is a new version: publish `0.5.0` after testing
`0.5.0-rc.1`.

## Failed releases

If checks or builds fail, nothing is published. Rerun a transient failure in
GitHub Actions. If code needs fixing, commit the fix and prepare a new version;
don't move an existing version tag. If the tag push itself fails, the command
prints the exact `git push` command to retry.

You can check a version without publishing anything:

```sh
cargo xtask release validate v0.4.0
```

Builds are unsigned. The README has first-run notes for Windows SmartScreen and
macOS Gatekeeper.
