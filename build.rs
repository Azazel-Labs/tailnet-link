//! Builds the vendored libtailscale (tsbridge/, Go) as a static C archive and
//! links it into the Rust binary. Go is only needed at build time; users get a
//! single executable.
//!
//! The C compiler cgo uses follows Cargo's conventions: `CC_<target>` or
//! `TARGET_CC`, else `MinGW` for Windows targets and the default `cc` elsewhere.

use std::{env, path::PathBuf, process::Command};

#[path = "localization/catalog.rs"]
mod catalog;

fn var(name: &str) -> String {
    env::var(name).unwrap_or_else(|_| panic!("Cargo sets {name} for build scripts"))
}

fn main() {
    println!("cargo:rerun-if-changed=tsbridge");
    println!("cargo:rerun-if-env-changed=GO");

    let out = PathBuf::from(var("OUT_DIR"));

    // Validate the Fluent catalogs and list them for src/i18n.rs.
    println!("cargo:rerun-if-changed=locales");
    println!("cargo:rerun-if-changed=i18n.toml");
    println!("cargo:rerun-if-changed=localization/catalog.rs");
    let catalogs = catalog::load(std::path::Path::new("locales")).expect("Invalid translation catalogs");
    let languages = format!(
        "static LANGUAGES: &[&str] = &{:?};
",
        catalogs.keys().collect::<Vec<_>>()
    );
    std::fs::write(out.join("translations.rs"), languages).expect("Write the language list");
    let target = var("TARGET");
    let target_os = var("CARGO_CFG_TARGET_OS");
    let target_arch = var("CARGO_CFG_TARGET_ARCH");

    let goos = match target_os.as_str() {
        "macos" => "darwin",
        other => other,
    };
    let goarch = match target_arch.as_str() {
        "x86_64" => "amd64",
        "aarch64" => "arm64",
        other => other,
    };

    let lib = out.join("libtsbridge.a");
    let mut cmd = Command::new(env::var("GO").unwrap_or_else(|_| "go".into()));
    cmd.current_dir("tsbridge")
        .args(["build", "-buildmode=c-archive", "-trimpath", "-ldflags=-s -w", "-o"])
        .arg(&lib)
        .arg(".")
        .env("CGO_ENABLED", "1")
        .env("GOOS", goos)
        .env("GOARCH", goarch);

    let cc_var = format!("CC_{}", target.replace('-', "_"));
    if let Ok(cc) = env::var(&cc_var).or_else(|_| env::var("TARGET_CC")) {
        cmd.env("CC", cc);
    } else if target_os == "windows" {
        let host_is_windows = env::var("HOST").is_ok_and(|h| h.contains("windows"));
        let cc = if host_is_windows {
            "gcc" // MinGW on a Windows machine (e.g. GitHub's Windows runners)
        } else if goarch == "arm64" {
            "aarch64-w64-mingw32-gcc"
        } else {
            "x86_64-w64-mingw32-gcc"
        };
        cmd.env("CC", cc);
    }

    // Icon, version information and the application manifest. Tailscale's
    // Windows code needs the manifest (see the comment inside it).
    if target_os == "windows" {
        println!("cargo:rerun-if-changed=assets/icons/tailnet-link.ico");
        println!("cargo:rerun-if-changed=packaging/windows/tailnet-link.exe.manifest");
        winresource::WindowsResource::new()
            .set_icon("assets/icons/tailnet-link.ico")
            .set_manifest_file("packaging/windows/tailnet-link.exe.manifest")
            .set("ProductName", "Tailnet Link")
            .set("CompanyName", "Azazel Labs LLC")
            .set("LegalCopyright", "Copyright © 2026 Azazel Labs LLC")
            // Task Manager and Process Explorer show this as the process name.
            .set("FileDescription", "Tailnet Link")
            .compile()
            .expect("Could not embed the Windows icon, version information and manifest");
    }

    let status = cmd.status().expect("couldn't run `go` (Go 1.27+ is needed at build time to compile libtailscale)");
    assert!(status.success(), "building tsbridge (libtailscale) failed");

    println!("cargo:rustc-link-search=native={}", out.display());
    println!("cargo:rustc-link-lib=static=tsbridge");

    // System libraries the Go runtime and Tailscale need.
    match target_os.as_str() {
        "windows" => {
            for l in [
                "ws2_32", "iphlpapi", "ntdll", "userenv", "bcrypt", "winmm", "advapi32", "crypt32", "secur32",
                "dnsapi", "netapi32", "ole32", "oleaut32", "shell32", "user32",
            ] {
                println!("cargo:rustc-link-lib={l}");
            }
        }
        "macos" => {
            for f in ["CoreFoundation", "Security", "SystemConfiguration", "IOKit"] {
                println!("cargo:rustc-link-lib=framework={f}");
            }
            println!("cargo:rustc-link-lib=resolv");
        }
        _ => {
            println!("cargo:rustc-link-lib=pthread");
            println!("cargo:rustc-link-lib=resolv");
            println!("cargo:rustc-link-lib=dl");
        }
    }
}
