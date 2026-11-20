use clap::{Parser, Subcommand};
use std::{env, error::Error, path::Path, process::Command};
mod release;

type Result<T> = std::result::Result<T, Box<dyn Error>>;

/// Tailnet Link developer tasks.
#[derive(Debug, Parser)]
#[command(name = "cargo xtask", bin_name = "cargo xtask")]
struct Cli {
    #[command(subcommand)]
    task: Task,
}

#[derive(Debug, Subcommand)]
enum Task {
    /// Bump, validate or publish a release version
    Release(release::Args),
}

fn main() {
    let cli = Cli::parse();
    if let Err(error) = run(cli.task) {
        eprintln!("xtask: {error}");
        std::process::exit(1);
    }
}

fn run(task: Task) -> Result<()> {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).parent().ok_or("Cannot locate workspace")?;
    env::set_current_dir(root)?;
    match task {
        Task::Release(args) => release::run(root, &args),
    }
}

/// The Cargo running this xtask (honouring toolchain overrides), in the workspace.
fn cargo(root: &Path) -> Command {
    let mut command = Command::new(env::var_os("CARGO").unwrap_or_else(|| "cargo".into()));
    command.current_dir(root);
    command
}

/// Run quietly and return trimmed stdout; a failure reports the command and its stderr.
fn output(command: &mut Command) -> Result<String> {
    let output = command.output()?;
    if !output.status.success() {
        let line = std::iter::once(command.get_program())
            .chain(command.get_args())
            .map(|part| part.to_string_lossy())
            .collect::<Vec<_>>()
            .join(" ");
        return Err(format!("{line} failed: {}", String::from_utf8_lossy(&output.stderr)).into());
    }
    Ok(String::from_utf8(output.stdout)?.trim().to_owned())
}

#[cfg(test)]
mod cli_tests {
    use super::*;
    use clap::CommandFactory;

    fn parse(line: &str) -> std::result::Result<Cli, clap::Error> {
        Cli::try_parse_from(std::iter::once("cargo-xtask").chain(line.split_whitespace()))
    }

    #[test]
    fn command_line_definition_is_valid() {
        Cli::command().debug_assert();
    }

    /// Every invocation in the workflows, VS Code tasks and docs must keep parsing.
    #[test]
    fn documented_invocations_parse() {
        for line in ["release prepare 0.1.0", "release validate v0.1.0", "release publish 0.1.0"] {
            if let Err(error) = parse(line) {
                panic!("{line}: {error}");
            }
        }
        for line in ["--help", "release --help"] {
            assert_eq!(parse(line).expect_err(line).kind(), clap::error::ErrorKind::DisplayHelp, "{line}");
        }
    }

    #[test]
    fn rejects_malformed_invocations() {
        for line in ["", "bogus", "release ship 1.0.0", "release prepare"] {
            assert!(parse(line).is_err(), "{line}");
        }
    }
}
