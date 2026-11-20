//! Icons drawn in code, so there are no image files to keep in sync.
//!
//! The mark is "fan-out": one machine (bottom left) with curved tails reaching
//! out to several tailnets. The app icon draws it in colour on a dark tile; the
//! tray icon draws it in one colour that shows the routing state.

pub type Rgba = [u8; 4];
/// A point on the 64-unit grid.
type Pt = (f64, f64);

pub const ON: Rgba = [0x22, 0xa0, 0x6b, 0xff]; // routing
pub const LOGIN: Rgba = [0xe6, 0xa1, 0x00, 0xff]; // needs login
pub const OFF: Rgba = [0x8c, 0x93, 0x9d, 0xff]; // paused / connecting
pub const BAD: Rgba = [0xd9, 0x3f, 0x3f, 0xff]; // problem

/// App icon colours (the Azazel Labs palette).
const TILE: Rgba = [0x18, 0x18, 0x18, 0xff];
const TEAL: Rgba = [0x00, 0xbf, 0xa5, 0xff];
const BLUE: Rgba = [0x44, 0x8a, 0xff, 0xff];
const PINK: Rgba = [0xe0, 0x40, 0xfb, 0xff];
const AMBER: Rgba = [0xff, 0xd7, 0x40, 0xff];

/// Geometry on a 64-unit grid.
const HOME: Pt = (15.0, 49.0);
/// Each tail: quadratic Bézier control point, end point, app colour.
const TAILS: [(Pt, Pt, Rgba); 3] =
    [((9.0, 24.0), (25.0, 11.0), BLUE), ((24.0, 22.0), (47.0, 17.0), PINK), ((35.0, 34.0), (53.0, 40.0), AMBER)];

/// Stroke width and radii (tail end, home): the tray glyph is heavier so it
/// stays legible at 16 px.
struct Weights {
    stroke: f64,
    end: f64,
    home: f64,
}
const APP: Weights = Weights { stroke: 4.0, end: 5.5, home: 8.5 };
const GLYPH: Weights = Weights { stroke: 5.0, end: 6.0, home: 9.0 };

enum Shape {
    Circle { c: Pt, r: f64 },
    Stroke { pts: Vec<Pt>, half: f64 },
    RoundRect { size: f64, r: f64 },
}

impl Shape {
    /// Signed distance in grid units (negative inside).
    fn sd(&self, p: Pt) -> f64 {
        match self {
            Shape::Circle { c, r } => dist(p, *c) - r,
            Shape::Stroke { pts, half } => {
                pts.windows(2).map(|w| seg_dist(p, w[0], w[1])).fold(f64::INFINITY, f64::min) - half
            }
            Shape::RoundRect { size, r } => {
                let h = size / 2.0;
                let q = ((p.0 - h).abs() - (h - r), (p.1 - h).abs() - (h - r));
                let outside = dist((q.0.max(0.0), q.1.max(0.0)), (0.0, 0.0));
                outside + q.0.max(q.1).min(0.0) - r
            }
        }
    }
}

fn dist(a: Pt, b: Pt) -> f64 {
    (a.0 - b.0).hypot(a.1 - b.1)
}

fn seg_dist(p: Pt, from: Pt, to: Pt) -> f64 {
    let along = (to.0 - from.0, to.1 - from.1);
    let len2 = along.0 * along.0 + along.1 * along.1;
    let t =
        if len2 == 0.0 { 0.0 } else { (((p.0 - from.0) * along.0 + (p.1 - from.1) * along.1) / len2).clamp(0.0, 1.0) };
    dist(p, (from.0 + t * along.0, from.1 + t * along.1))
}

/// A quadratic Bézier from `start` through control `ctrl` to `end`, flattened.
fn quad(start: Pt, ctrl: Pt, end: Pt) -> Vec<Pt> {
    (0..=32)
        .map(|step| {
            let t = f64::from(step) / 32.0;
            let (w0, w1, w2) = ((1.0 - t) * (1.0 - t), 2.0 * (1.0 - t) * t, t * t);
            (w0 * start.0 + w1 * ctrl.0 + w2 * end.0, w0 * start.1 + w1 * ctrl.1 + w2 * end.1)
        })
        .collect()
}

/// The mark as layers, back to front. `tint` replaces every colour (tray glyph).
fn mark(w: &Weights, tint: Option<Rgba>) -> Vec<(Shape, Rgba)> {
    let col = |c: Rgba| tint.unwrap_or(c);
    let mut layers = Vec::new();
    for (ctrl, end, c) in TAILS {
        layers.push((Shape::Stroke { pts: quad(HOME, ctrl, end), half: w.stroke / 2.0 }, col(c)));
    }
    for (_, end, c) in TAILS {
        layers.push((Shape::Circle { c: end, r: w.end }, col(c)));
    }
    layers.push((Shape::Circle { c: HOME, r: w.home }, col(TEAL)));
    layers
}

/// Rasterises layers at n×n with analytic anti-aliasing. Straight (not
/// premultiplied) alpha.
fn render(layers: &[(Shape, Rgba)], n: u32) -> Vec<u8> {
    let scale = 64.0 / f64::from(n); // grid units per pixel
    let mut px = vec![0u8; (n * n * 4) as usize];
    for y in 0..n {
        for x in 0..n {
            let p = ((f64::from(x) + 0.5) * scale, (f64::from(y) + 0.5) * scale);
            // Straight-alpha "over" compositing of each layer onto the pixel.
            let (mut rgb, mut alpha) = ([0.0f64; 3], 0.0f64);
            for (shape, colour) in layers {
                let cover = (0.5 - shape.sd(p) / scale).clamp(0.0, 1.0) * f64::from(colour[3]) / 255.0;
                if cover <= 0.0 {
                    continue;
                }
                let out_alpha = cover + alpha * (1.0 - cover);
                for (dst, src) in rgb.iter_mut().zip(*colour) {
                    *dst = (f64::from(src) * cover + *dst * alpha * (1.0 - cover)) / out_alpha;
                }
                alpha = out_alpha;
            }
            let i = ((y * n + x) * 4) as usize;
            #[allow(clippy::cast_possible_truncation, clippy::cast_sign_loss)]
            let to_u8 = |v: f64| v.round().clamp(0.0, 255.0) as u8;
            px[i..i + 4].copy_from_slice(&[to_u8(rgb[0]), to_u8(rgb[1]), to_u8(rgb[2]), to_u8(alpha * 255.0)]);
        }
    }
    px
}

/// Tray icon: the mark in one colour on a transparent background, n×n RGBA.
pub fn tray(c: Rgba, n: u32) -> Vec<u8> {
    render(&mark(&GLYPH, Some(c)), n)
}

/// App icon: the colour mark on a dark rounded tile, n×n RGBA.
pub fn app(n: u32) -> Vec<u8> {
    let mut layers = vec![(Shape::RoundRect { size: 64.0, r: 14.0 }, TILE)];
    layers.extend(mark(&APP, None));
    render(&layers, n)
}

pub fn png(rgba: &[u8], n: u32) -> Vec<u8> {
    let mut out = Vec::new();
    {
        let mut enc = png::Encoder::new(&mut out, n, n);
        enc.set_color(png::ColorType::Rgba);
        enc.set_depth(png::BitDepth::Eight);
        let mut w = enc.write_header().expect("png header");
        w.write_image_data(rgba).expect("png data");
    }
    out
}

pub const APP_ICON_SIZES: [u32; 9] = [16, 20, 24, 32, 40, 48, 64, 128, 256];
/// Size of the exported PNG (Linux and macOS packaging scale it down).
pub const APP_PNG_SIZE: u32 = 512;

/// Multi-size .ico of the app icon: PNG-compressed at 256px (as Windows
/// expects), classic 32-bit bitmaps for the smaller sizes.
pub fn ico(sizes: &[u32]) -> Vec<u8> {
    let entries: Vec<Vec<u8>> =
        sizes.iter().map(|&n| if n >= 256 { png(&app(n), n) } else { bmp_dib(&app(n), n) }).collect();
    let mut b = Vec::new();
    b.extend_from_slice(&0u16.to_le_bytes());
    b.extend_from_slice(&1u16.to_le_bytes());
    b.extend_from_slice(&(entries.len() as u16).to_le_bytes());
    let mut offset = 6 + 16 * entries.len();
    for (i, &n) in sizes.iter().enumerate() {
        let dim = if n >= 256 { 0 } else { n as u8 };
        b.extend_from_slice(&[dim, dim, 0, 0]);
        b.extend_from_slice(&1u16.to_le_bytes());
        b.extend_from_slice(&32u16.to_le_bytes());
        b.extend_from_slice(&(entries[i].len() as u32).to_le_bytes());
        b.extend_from_slice(&(offset as u32).to_le_bytes());
        offset += entries[i].len();
    }
    for e in entries {
        b.extend_from_slice(&e);
    }
    b
}

fn bmp_dib(rgba: &[u8], n: u32) -> Vec<u8> {
    let mask_row = n.div_ceil(32) * 4;
    let mut b = Vec::new();
    for v in [40u32, n, n * 2] {
        b.extend_from_slice(&v.to_le_bytes());
    }
    b.extend_from_slice(&1u16.to_le_bytes());
    b.extend_from_slice(&32u16.to_le_bytes());
    for v in [0u32, n * n * 4, 0, 0, 0, 0] {
        b.extend_from_slice(&v.to_le_bytes());
    }
    for y in (0..n).rev() {
        for x in 0..n {
            let i = ((y * n + x) * 4) as usize;
            b.extend_from_slice(&[rgba[i + 2], rgba[i + 1], rgba[i], rgba[i + 3]]);
        }
    }
    b.extend(std::iter::repeat_n(0u8, (mask_row * n) as usize));
    b
}

/// Writes the app icon for packaging: .ico (multi-size) or .png.
pub fn export(path: &std::path::Path) -> Result<(), String> {
    let data = match path.extension().and_then(|e| e.to_str()).map(str::to_lowercase).as_deref() {
        Some("ico") => ico(&APP_ICON_SIZES),
        Some("png") => png(&app(APP_PNG_SIZE), APP_PNG_SIZE),
        _ => return Err("--export-icon: use a .ico or .png file name".into()),
    };
    if let Some(dir) = path.parent() {
        let _ = std::fs::create_dir_all(dir);
    }
    std::fs::write(path, data).map_err(|e| e.to_string())
}

#[cfg(test)]
mod tests {
    use super::*;

    fn alpha(px: &[u8], n: u32, x: u32, y: u32) -> u8 {
        px[((y * n + x) * 4 + 3) as usize]
    }

    #[test]
    fn ico_layout() {
        let b = ico(&APP_ICON_SIZES);
        assert_eq!(b[2], 1);
        assert_eq!(b[4] as usize, APP_ICON_SIZES.len());
        let last = 6 + 16 * (APP_ICON_SIZES.len() - 1);
        assert_eq!(b[last], 0, "256px entry has dimension 0");
        let off = u32::from_le_bytes(b[last + 12..last + 16].try_into().unwrap()) as usize;
        assert_eq!(&b[off + 1..off + 4], b"PNG");
    }

    #[test]
    fn tray_glyph_drawn() {
        for n in [16u32, 32, 256] {
            let px = tray(ON, n);
            assert_eq!(alpha(&px, n, n - 1, n - 1), 0, "{n}px: corner transparent");
            // The home node, bottom left.
            let (x, y) = (n * 15 / 64, n * 49 / 64);
            assert_eq!(alpha(&px, n, x, y), 255, "{n}px: home node drawn");
            assert_eq!(&px[((y * n + x) * 4) as usize..][..3], &ON[..3], "{n}px: tinted");
        }
    }

    #[test]
    fn app_icon_on_tile() {
        let n = 64;
        let px = app(n);
        assert_eq!(alpha(&px, n, 0, 0), 0, "rounded corner transparent");
        assert_eq!(&px[((32 * n + 60) * 4) as usize..][..4], &TILE, "tile behind the mark");
        let i = ((49 * n + 15) * 4) as usize;
        assert_eq!(&px[i..i + 4], &TEAL, "home node in teal");
    }
}

#[cfg(test)]
mod asset_tests {
    /// The committed icon files (used by the installers) must match the code.
    #[test]
    fn committed_assets_match() {
        let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("assets").join("icons");
        assert_eq!(
            std::fs::read(dir.join("tailnet-link.ico")).unwrap(),
            super::ico(&super::APP_ICON_SIZES),
            "assets/icons/tailnet-link.ico is stale: run `tailnet-link --export-icon assets/icons/tailnet-link.ico`"
        );
        assert_eq!(
            std::fs::read(dir.join("tailnet-link.png")).unwrap(),
            super::png(&super::app(super::APP_PNG_SIZE), super::APP_PNG_SIZE),
            "assets/icons/tailnet-link.png is stale: run `tailnet-link --export-icon assets/icons/tailnet-link.png`"
        );
    }
}
