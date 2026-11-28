# Releasing Tailnet Link

Release tooling is Rust: `cargo xtask`. You need Rust and Git, with push access to
the repository. VS Code provides the same commands under **Tasks: Run Task →
Tailnet Link: Release …**.

## Release by raising the version

The version in Cargo.toml's `[workspace.package]` is the one source of truth. After
CI passes on a push to `main`, the
[Auto release workflow](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/auto-release.yml)
reads it: if no `vX.Y.Z` tag has that version yet, it tags the commit, which starts
the Release workflow below; otherwise it does nothing. So to release `0.8.0`:

```sh
cargo xtask release prepare 0.8.0
git commit -am "Release 0.8.0"
git push origin main
```

`release prepare` updates the workspace version and the lockfile without upgrading
third-party dependencies. Leave the version alone to let changes collect; they go
out with the next version pushed. When several pushes land while a release builds,
releases run one at a time, and a push that main has already moved past is left to
the newer push's run. Nothing is committed back to `main`, and if CI fails nothing
is tagged: the next push that passes releases the version then. A version behind
the newest tag fails the workflow rather than releasing.

## Publish a version manually

To tag by hand instead, set and push the version as above, then, on a clean `main`
at the same commit as `origin/main`:

```sh
cargo xtask release publish 0.8.0
```

Publish creates an annotated `v0.8.0` tag and pushes it. It never force-pushes or
replaces a version tag.

Follow the [Release workflow](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/release.yml).
It checks that Cargo.toml has the tag's version, runs the full CI (formatting, strict
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
