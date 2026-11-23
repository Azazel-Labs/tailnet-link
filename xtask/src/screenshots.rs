//! Capture the app's fictional demo views as PNGs for the README.
use crate::Result;
use std::{
    env, fs,
    io::BufWriter,
    path::{Path, PathBuf},
    process::Command,
    time::{Duration, Instant},
};

/// (file name, demo view, window size in points)
const VIEWS: [(&str, &str, &str); 5] = [
    ("tailnets", "tailnets", "760x1203"),
    ("welcome", "welcome", "760x560"),
    ("sign-in", "signin", "760x775"),
    ("settings", "settings", "760x1100"),
    ("forward", "forward", "760x860"),
];

#[derive(Debug, clap::Args)]
pub struct Args {
    /// Interface language, as a catalog code such as fr or zh-Hant
    #[arg(long, default_value = "en")]
    language: String,
    /// Rewrite the PNGs from the last captures without opening the app
    #[arg(long)]
    render_only: bool,
}

pub fn run(root: &Path, args: &Args) -> Result<()> {
    let target = root.join("target");
    let suffix = if args.language == "en" { String::new() } else { format!(".{}", args.language) };
    if !args.render_only {
        println!("Building the demo capture feature…");
        let triple = build_target();
        let mut build = crate::cargo(root);
        build.args(["build", "--package", "tailnet-link", "--features", "screenshots", "--locked"]);
        if let Some(triple) = &triple {
            build.args(["--target", triple]);
        }
        crate::run_checked(&mut build, "Screenshot build failed")?;
        let binary = format!("tailnet-link{}", env::consts::EXE_SUFFIX);
        let built = triple.map_or_else(|| target.clone(), |t| target.join(t)).join("debug").join(&binary);
        let config = target.join("demo-config");
        for (name, view, size) in VIEWS {
            println!("Capturing {name} ({})…", args.language);
            capture(&built, &config, &capture_path(&target, name, &suffix), view, size, &args.language)?;
        }
    }
    let out = root.join("docs/images");
    fs::create_dir_all(&out)?;
    for (name, _, _) in VIEWS {
        let data = fs::read(capture_path(&target, name, &suffix))?;
        let (width, height, rgb) = ppm(&data)?;
        write_png(&out.join(format!("{name}{suffix}.png")), width, height, rgb)?;
    }
    println!("Wrote {} screenshots in docs/images.", VIEWS.len());
    Ok(())
}

fn capture_path(target: &Path, name: &str, suffix: &str) -> PathBuf {
    target.join(format!("demo-{name}{suffix}.ppm"))
}

/// The target to build for: Windows builds the Go bridge with the GNU toolchain, as in CI.
fn build_target() -> Option<String> {
    env::var("CARGO_BUILD_TARGET").ok().or_else(|| cfg!(windows).then(|| "x86_64-pc-windows-gnu".to_owned()))
}

fn capture(executable: &Path, config: &Path, output: &Path, view: &str, size: &str, language: &str) -> Result<()> {
    if output.exists() {
        fs::remove_file(output)?;
    }
    // An empty settings folder, so nothing on this computer leaks into the pictures.
    if config.exists() {
        fs::remove_dir_all(config)?;
    }
    fs::create_dir_all(config)?;
    let mut command = Command::new(executable);
    command
        .env("TAILNET_LINK_DEMO_CAPTURE", output)
        .env("TAILNET_LINK_DEMO_VIEW", view)
        .env("TAILNET_LINK_DEMO_SIZE", size)
        .env("TAILNET_LINK_DEMO_LANGUAGE", language)
        .env("TAILNET_LINK_CONFIG_DIR", config);
    let mut child = command.spawn()?;
    let started = Instant::now();
    loop {
        if let Some(status) = child.try_wait()? {
            if !status.success() || !output.is_file() {
                return Err(format!("Capture failed ({status}): {}", output.display()).into());
            }
            return Ok(());
        }
        if started.elapsed() > Duration::from_secs(120) {
            child.kill()?;
            child.wait()?;
            return Err("Capture timed out; captures need a graphical session and a working GPU driver".into());
        }
        std::thread::sleep(Duration::from_millis(100));
    }
}

fn dimensions(line: &str) -> Result<(u32, u32)> {
    let mut parts = line.split_whitespace();
    let (Some(width), Some(height), None) = (parts.next(), parts.next(), parts.next()) else {
        return Err("Expected width and height".into());
    };
    let (width, height): (u32, u32) = (width.parse()?, height.parse()?);
    if width == 0 || height == 0 || width > 8192 || height > 8192 {
        return Err("Capture dimensions out of range".into());
    }
    Ok((width, height))
}

fn ppm(data: &[u8]) -> Result<(u32, u32, &[u8])> {
    let mut parts = data.splitn(4, |b| *b == b'\n');
    if parts.next() != Some(b"P6") {
        return Err("Expected P6 capture".into());
    }
    let (width, height) = dimensions(std::str::from_utf8(parts.next().ok_or("Missing PPM dimensions")?)?)?;
    if parts.next() != Some(b"255") {
        return Err("Expected 8-bit PPM capture".into());
    }
    let rgb = parts.next().ok_or("Missing PPM pixels")?;
    if rgb.len() != width as usize * height as usize * 3 {
        return Err("Truncated PPM capture".into());
    }
    Ok((width, height, rgb))
}

fn write_png(path: &Path, width: u32, height: u32, rgb: &[u8]) -> Result<()> {
    let mut encoder = png::Encoder::new(BufWriter::new(fs::File::create(path)?), width, height);
    encoder.set_color(png::ColorType::Rgb);
    encoder.set_depth(png::BitDepth::Eight);
    let mut writer = encoder.write_header()?;
    writer.write_image_data(rgb)?;
    writer.finish()?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn binary_ppm_preserves_whitespace_pixels_and_rejects_truncation() -> Result<()> {
        let (_, _, pixels) = ppm(b"P6\n1 1\n255\n\n\r\t")?;
        assert_eq!(pixels, b"\n\r\t");
        assert!(ppm(b"P6\n1 1\n255\n\0").is_err());
        assert!(ppm(b"P6\n1 1 1\n255\n\0\0\0").is_err());
        Ok(())
    }
}
