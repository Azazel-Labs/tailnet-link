//! Asks GitHub whether there's a newer release. Only the version number and
//! the release page come back; nothing is downloaded or installed.

use std::time::Duration;

use crate::core::Update;

const LATEST: &str = "https://api.github.com/repos/Azazel-Labs/tailnet-link/releases/latest";

/// How often to ask, and how long to wait after starting before the first time.
pub const EVERY: Duration = Duration::from_hours(12);
pub const FIRST_AFTER: Duration = Duration::from_secs(20);

/// The latest release, if it's newer than this build.
pub fn check() -> Result<Option<Update>, String> {
    let agent: ureq::Agent = ureq::Agent::config_builder().timeout_global(Some(Duration::from_secs(20))).build().into();
    let body = agent
        .get(LATEST)
        .header("User-Agent", concat!("tailnet-link/", env!("CARGO_PKG_VERSION")))
        .header("Accept", "application/vnd.github+json")
        .call()
        .map_err(|e| e.to_string())?
        .body_mut()
        .read_to_string()
        .map_err(|e| e.to_string())?;
    let v: serde_json::Value = serde_json::from_str(&body).map_err(|e| e.to_string())?;
    if v["draft"].as_bool() == Some(true) || v["prerelease"].as_bool() == Some(true) {
        return Ok(None);
    }
    let tag = v["tag_name"].as_str().unwrap_or_default();
    let url = v["html_url"].as_str().unwrap_or_default();
    let version = tag.trim_start_matches('v');
    if !url.starts_with("https://github.com/") || !is_newer(version, env!("CARGO_PKG_VERSION")) {
        return Ok(None);
    }
    Ok(Some(Update { version: version.to_owned(), url: url.to_owned() }))
}

/// "1.2.3" > "1.2.0"? Anything that isn't plain numbers ("1.3.0-beta") is never newer.
pub fn is_newer(candidate: &str, current: &str) -> bool {
    fn parse(v: &str) -> Option<Vec<u64>> {
        v.split('.').map(|p| p.parse().ok()).collect()
    }
    match (parse(candidate), parse(current)) {
        (Some(a), Some(b)) => a > b,
        _ => false,
    }
}

#[cfg(test)]
mod tests {
    use super::is_newer;

    #[test]
    fn versions_compare_by_number() {
        assert!(is_newer("0.5.0", "0.4.0"));
        assert!(is_newer("0.10.0", "0.9.3"));
        assert!(is_newer("1.0.0", "0.99.99"));
        assert!(!is_newer("0.4.0", "0.4.0"));
        assert!(!is_newer("0.3.9", "0.4.0"));
        assert!(!is_newer("0.5.0-beta", "0.4.0"));
        assert!(!is_newer("", "0.4.0"));
    }
}
