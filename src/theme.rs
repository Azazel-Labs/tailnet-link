//! Shared visual language: palette, fonts, cards, status pills, buttons and
//! dialogs. Dark, in the Azazel Labs style.

use eframe::egui::{self, Color32, CornerRadius, FontId, Margin, RichText, Stroke, TextStyle, vec2};

use crate::icon;

pub const BG: Color32 = Color32::from_rgb(17, 18, 18);
/// The header and cards.
pub const SURFACE: Color32 = Color32::from_rgb(24, 25, 25);
/// Rows inside a card, and text fields.
pub const RAISED: Color32 = Color32::from_rgb(31, 33, 34);
pub const BORDER: Color32 = Color32::from_rgb(43, 44, 44);
pub const PANEL_EDGE: Color32 = Color32::from_rgb(62, 69, 78);
pub const TEXT: Color32 = Color32::from_rgb(216, 216, 216);
pub const STRONG: Color32 = Color32::from_rgb(242, 242, 242);
pub const MUTED: Color32 = Color32::from_rgb(153, 153, 153);
pub const ACCENT: Color32 = Color32::from_rgb(117, 169, 214);
pub const DANGER: Color32 = Color32::from_rgb(226, 104, 92);
/// Background of an informational note or the unsaved-changes bar.
pub const NOTE_BG: Color32 = Color32::from_rgb(29, 38, 46);
/// A row or tile under the pointer.
pub const ROW_HOVER: Color32 = Color32::from_rgb(36, 39, 42);
/// A switched-off toggle's track.
pub const TOGGLE_OFF: Color32 = Color32::from_rgb(57, 62, 68);
/// Dims the window behind a modal dialog.
pub const BACKDROP: Color32 = Color32::from_black_alpha(170);
/// Height of dialog and header action buttons.
pub const BUTTON_HEIGHT: f32 = 34.0;

pub use egui_phosphor::regular as icons;

/// How healthy something is; the same four states as the tray icon.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Tone {
    /// Routing.
    Good,
    /// Needs you to sign in.
    Warn,
    /// Paused, connecting or idle.
    Idle,
    /// Something is wrong.
    Bad,
}

impl Tone {
    /// For text and dots on the dark background.
    pub const fn color(self) -> Color32 {
        match self {
            Tone::Good => Color32::from_rgb(64, 201, 140),
            Tone::Warn => Color32::from_rgb(236, 180, 50),
            Tone::Idle => Color32::from_rgb(150, 157, 167),
            Tone::Bad => Color32::from_rgb(236, 104, 94),
        }
    }

    /// The tray icon's tint.
    pub const fn tray(self) -> icon::Rgba {
        match self {
            Tone::Good => icon::ON,
            Tone::Warn => icon::LOGIN,
            Tone::Idle => icon::OFF,
            Tone::Bad => icon::BAD,
        }
    }

    /// An icon that says the same thing as the colour.
    pub const fn symbol(self) -> &'static str {
        match self {
            Tone::Good => icons::CHECK_CIRCLE,
            Tone::Warn => icons::SIGN_IN,
            Tone::Idle => icons::PAUSE_CIRCLE,
            Tone::Bad => icons::WARNING_CIRCLE,
        }
    }
}

mod system_fonts;

/// Thai is small enough (37 KB) to bundle in every build.
const THAI: &[u8] = include_bytes!("../assets/fonts/NotoSansThai-Regular.ttf");

/// Han characters have regional glyph forms, so each region has its own face.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Region {
    Sc,
    Kr,
    Jp,
    Tc,
}

impl Region {
    /// In discriminant order, which is also the fallback order after the UI language's.
    const ALL: [Region; 4] = [Region::Sc, Region::Kr, Region::Jp, Region::Tc];

    fn key(self) -> &'static str {
        match self {
            Region::Sc => "CJK SC",
            Region::Kr => "CJK KR",
            Region::Jp => "CJK JP",
            Region::Tc => "CJK TC",
        }
    }
}

/// The operating system's face for `region`, if it has one.
fn cjk_font(region: Region) -> Option<egui::FontData> {
    let face = system_fonts::cjk(region)?;
    Some(egui::FontData { index: face.index, ..egui::FontData::from_static(face.bytes) })
}

/// Ascent, descent and line gap as fractions of the em, as egui reads them.
fn vertical_metrics(bytes: &[u8], index: u32) -> Option<(f32, f32, f32)> {
    let face = ttf_parser::Face::parse(bytes, index).ok()?;
    let em = f32::from(face.units_per_em());
    Some((f32::from(face.ascender()) / em, f32::from(face.descender()) / em, f32::from(face.line_gap()) / em))
}

/// egui centres a fallback face's line box in the main font's, so a face with
/// other proportions lands above or below the Latin baseline. Yu Gothic, with
/// its half-em line gap, sits visibly high. Returns the downward shift, as a
/// fraction of the font size, that puts `fallback` back on `main`'s baseline.
fn baseline_shift(main: &[u8], fallback: &[u8], index: u32) -> f32 {
    let (Some((main_ascent, main_descent, main_gap)), Some((ascent, descent, gap))) =
        (vertical_metrics(main, 0), vertical_metrics(fallback, index))
    else {
        return 0.0;
    };
    let (main_height, height) = (main_ascent - main_descent + main_gap, ascent - descent + gap);
    (main_ascent - ascent) - 0.5 * (main_height - height)
}

/// `data` shifted onto the baseline of egui's proportional font.
fn on_baseline(fonts: &egui::FontDefinitions, mut data: egui::FontData) -> egui::FontData {
    let main = fonts.families.get(&egui::FontFamily::Proportional).and_then(|names| names.first());
    if let Some(main) = main.and_then(|name| fonts.font_data.get(name)) {
        data.tweak.y_offset_factor += baseline_shift((*main.font).as_ref(), (*data.font).as_ref(), data.index);
    }
    data
}

/// Shared Han characters have different regional glyph forms; the UI language's come first.
fn primary_font(language: &str) -> Region {
    match language {
        "ja" => Region::Jp,
        "ko" => Region::Kr,
        "zh-Hant" => Region::Tc,
        _ => Region::Sc,
    }
}

/// egui's fonts plus fallbacks for every UI language, with `language`'s CJK
/// region first. Installed for every language so the native names in the
/// language picker render too.
pub fn set_fonts(ctx: &egui::Context, language: &str) {
    let mut fonts = egui::FontDefinitions::default();
    let primary = primary_font(language);
    let mut order = Vec::new();
    for region in std::iter::once(primary).chain(Region::ALL.into_iter().filter(|&r| r != primary)) {
        if let Some(data) = cjk_font(region) {
            let data = on_baseline(&fonts, data);
            fonts.font_data.insert(region.key().into(), data.into());
            order.push(region.key());
        }
    }
    let thai = on_baseline(&fonts, egui::FontData::from_static(THAI));
    fonts.font_data.insert("Noto Sans Thai".into(), thai.into());
    order.push("Noto Sans Thai");
    for family in [egui::FontFamily::Proportional, egui::FontFamily::Monospace] {
        fonts.families.entry(family).or_default().extend(order.iter().map(|&name| name.to_owned()));
    }
    // Phosphor icons (MIT) live in the Private Use Area. Last in the chain, so
    // they can only supply icons and never shadow text glyphs.
    fonts
        .font_data
        .insert("Phosphor".into(), egui::FontData::from_static(egui_phosphor::Variant::Regular.font_bytes()).into());
    fonts.families.entry(egui::FontFamily::Proportional).or_default().push("Phosphor".into());
    ctx.set_fonts(fonts);
}

pub fn apply(ctx: &egui::Context, language: &str) {
    set_fonts(ctx, language);
    ctx.set_theme(egui::Theme::Dark);
    let mut style = (*ctx.style_of(egui::Theme::Dark)).clone();
    style.visuals = egui::Visuals::dark();
    let v = &mut style.visuals;
    v.panel_fill = BG;
    v.window_fill = SURFACE;
    v.extreme_bg_color = RAISED;
    v.faint_bg_color = Color32::from_rgb(30, 31, 31);
    v.override_text_color = Some(TEXT);
    v.window_corner_radius = CornerRadius::same(10);
    v.menu_corner_radius = CornerRadius::same(8);
    v.window_stroke = Stroke::new(1.0, PANEL_EDGE);
    v.selection.bg_fill = Color32::from_rgb(45, 63, 82);
    v.selection.stroke = Stroke::new(1.0, ACCENT);
    v.hyperlink_color = ACCENT;
    v.warn_fg_color = Tone::Warn.color();
    v.error_fg_color = Tone::Bad.color();
    v.text_edit_bg_color = Some(RAISED);
    for widget in [
        &mut v.widgets.noninteractive,
        &mut v.widgets.inactive,
        &mut v.widgets.hovered,
        &mut v.widgets.active,
        &mut v.widgets.open,
    ] {
        widget.corner_radius = CornerRadius::same(6);
        widget.bg_stroke = Stroke::new(1.0, BORDER);
        widget.fg_stroke = Stroke::new(1.0, TEXT);
    }
    v.widgets.noninteractive.bg_stroke = Stroke::new(1.0, BORDER);
    v.widgets.inactive.weak_bg_fill = Color32::from_rgb(38, 40, 41);
    v.widgets.inactive.bg_fill = Color32::from_rgb(38, 40, 41);
    v.widgets.open.weak_bg_fill = BORDER;
    v.widgets.hovered.weak_bg_fill = Color32::from_rgb(52, 59, 68);
    v.widgets.hovered.bg_fill = Color32::from_rgb(52, 59, 68);
    v.widgets.hovered.bg_stroke = Stroke::new(1.0, Color32::from_rgb(102, 124, 146));
    v.widgets.hovered.fg_stroke = Stroke::new(1.0, Color32::WHITE);
    v.widgets.active.weak_bg_fill = Color32::from_rgb(61, 70, 81);
    v.widgets.active.bg_stroke = Stroke::new(1.0, ACCENT);
    style.spacing.item_spacing = vec2(8.0, 8.0);
    style.spacing.button_padding = vec2(12.0, 6.0);
    style.spacing.interact_size = vec2(32.0, 28.0);
    style.spacing.menu_margin = Margin::same(6);
    style.animation_time = 0.16;
    style.text_styles.insert(TextStyle::Small, FontId::proportional(12.0));
    style.text_styles.insert(TextStyle::Body, FontId::proportional(14.0));
    style.text_styles.insert(TextStyle::Button, FontId::proportional(14.0));
    style.text_styles.insert(TextStyle::Monospace, FontId::monospace(13.0));
    style.text_styles.insert(TextStyle::Heading, FontId::proportional(20.0));
    ctx.set_style_of(egui::Theme::Dark, style);
}

/// A card: one tailnet, or one Settings section.
pub fn card() -> egui::Frame {
    egui::Frame::new().fill(SURFACE).stroke(Stroke::new(1.0, BORDER)).corner_radius(10).inner_margin(16)
}

/// A row inside a card (a machine, a port forward).
pub fn row_frame(hovered: bool) -> egui::Frame {
    egui::Frame::new()
        .fill(if hovered { ROW_HOVER } else { RAISED })
        .corner_radius(8)
        .inner_margin(Margin::symmetric(10, 6))
}

/// A tinted note, such as sign-in help.
pub fn note_frame() -> egui::Frame {
    egui::Frame::new().fill(NOTE_BG).corner_radius(8).inner_margin(Margin::symmetric(12, 8))
}

/// The raised panel of a modal dialog.
pub fn modal_frame() -> egui::Frame {
    egui::Frame::new()
        .fill(SURFACE)
        .stroke(Stroke::new(1.0, PANEL_EDGE))
        .corner_radius(14)
        .inner_margin(22)
        .shadow(egui::epaint::Shadow { offset: [0, 12], blur: 40, spread: 0, color: Color32::from_black_alpha(120) })
}

/// A modal dialog over a dimmed window, in [`modal_frame`].
pub fn modal(id: &str) -> egui::Modal {
    egui::Modal::new(egui::Id::unique(id)).backdrop_color(BACKDROP).frame(modal_frame())
}

/// The main action: bold dark text on the accent.
pub fn primary_button(text: impl Into<String>) -> egui::Button<'static> {
    filled_button(text, ACCENT)
}

/// A destructive main action.
pub fn danger_button(text: impl Into<String>) -> egui::Button<'static> {
    filled_button(text, DANGER)
}

fn filled_button(text: impl Into<String>, fill: Color32) -> egui::Button<'static> {
    egui::Button::new(RichText::new(text).strong().color(BG)).fill(fill).min_size(vec2(0.0, BUTTON_HEIGHT))
}

/// A secondary action, such as Cancel.
pub fn secondary_button(text: impl Into<String>) -> egui::Button<'static> {
    egui::Button::new(text.into()).min_size(vec2(88.0, BUTTON_HEIGHT))
}

/// A frameless icon that shows a frame on hover. Give it a tooltip.
pub fn icon_button(symbol: &str) -> egui::Button<'static> {
    egui::Button::new(RichText::new(symbol).size(17.0)).frame_when_inactive(false).min_size(vec2(30.0, 28.0))
}

/// An icon followed by text.
pub fn with_icon(symbol: &str, text: &str) -> String {
    format!("{symbol}  {text}")
}

/// A small coloured status label.
pub fn pill(ui: &mut egui::Ui, tone: Tone, text: &str) {
    egui::Frame::new()
        .fill(tone.color().gamma_multiply(0.16))
        .corner_radius(10)
        .inner_margin(Margin::symmetric(8, 2))
        .show(ui, |ui| {
            ui.label(RichText::new(text).size(12.0).strong().color(tone.color()));
        });
}

/// A small coloured dot.
pub fn dot(ui: &mut egui::Ui, tone: Tone) {
    let (rect, _) = ui.allocate_exact_size(vec2(10.0, 10.0), egui::Sense::hover());
    ui.painter().circle_filled(rect.center(), 4.0, tone.color());
}

/// A card's heading: icon, title and an optional line of help below.
pub fn section_heading(ui: &mut egui::Ui, symbol: &str, title: &str, help: Option<&str>) {
    ui.label(RichText::new(with_icon(symbol, title)).size(16.0).strong().color(STRONG));
    if let Some(help) = help {
        ui.add(egui::Label::new(RichText::new(help).color(MUTED)).wrap());
    }
    ui.add_space(4.0);
}

/// Muted secondary text.
pub fn muted(text: impl Into<String>) -> RichText {
    RichText::new(text).color(MUTED)
}

/// An on/off switch. Returns its response; `changed()` when flipped.
pub fn toggle(ui: &mut egui::Ui, value: &mut bool, label: &str) -> egui::Response {
    let (rect, mut response) = ui.allocate_exact_size(vec2(38.0, 22.0), egui::Sense::click());
    if response.clicked() {
        *value = !*value;
        response.mark_changed();
    }
    response.widget_info(|| egui::WidgetInfo::selected(egui::Role::CheckBox, ui.is_enabled(), *value, label));
    let t = ui.ctx().animate_bool(response.id, *value);
    let fill = if *value { ACCENT } else { TOGGLE_OFF };
    ui.painter().rect_filled(rect.shrink(1.0), 10, if ui.is_enabled() { fill } else { fill.gamma_multiply(0.4) });
    if response.has_focus() || response.hovered() {
        ui.painter().rect_stroke(rect, 11, Stroke::new(1.0, ACCENT), egui::StrokeKind::Outside);
    }
    ui.painter().circle_filled(
        egui::pos2(rect.left() + 11.0 + t * 16.0, rect.center().y),
        7.0,
        if *value { BG } else { TEXT },
    );
    response
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fallback_faces_are_shifted_onto_the_latin_baseline() {
        let fonts = egui::FontDefinitions::default();
        let main = &fonts.font_data[&fonts.families[&egui::FontFamily::Proportional][0]];
        let main = (*main.font).as_ref();
        assert!(baseline_shift(main, main, 0).abs() < 1e-6, "the main font needs no shift");
        // Noto Sans Thai's deeper descent puts its box 0.05 em high when centred.
        let thai = on_baseline(&fonts, egui::FontData::from_static(THAI)).tweak.y_offset_factor;
        assert!((thai - 0.052).abs() < 0.005, "{thai}");
        assert!(baseline_shift(main, b"not a font", 0).abs() < f32::EPSILON);
    }

    #[test]
    fn icons_resolve_from_the_bundled_icon_font() {
        let ctx = egui::Context::default();
        set_fonts(&ctx, "en");
        let mut output = ctx.run_ui(egui::RawInput::default(), |ui| {
            let characters = ui.fonts_mut(|fonts| fonts.characters(&egui::FontFamily::Proportional).clone());
            for symbol in [icons::TRASH, icons::GLOBE, icons::PLUGS_CONNECTED, Tone::Warn.symbol()] {
                let c = symbol.chars().next().expect("icon codepoint");
                assert!(characters.contains_key(&c), "{symbol:?} missing");
            }
        });
        output.textures_delta.clear();
    }

    /// Every catalog's text renders: Thai always, CJK wherever the system has the fonts.
    #[test]
    fn every_language_has_font_coverage() {
        let ctx = egui::Context::default();
        for language in crate::i18n::languages() {
            set_fonts(&ctx, language);
            let mut output = ctx.run_ui(egui::RawInput::default(), |ui| {
                let definitions = ui.fonts_mut(|fonts| fonts.definitions().clone());
                let proportional = &definitions.families[&egui::FontFamily::Proportional];
                assert_eq!(proportional.last().map(String::as_str), Some("Phosphor"), "{language}");
                if let Some(first) = std::iter::once(primary_font(language))
                    .chain(Region::ALL)
                    .find(|&region| cjk_font(region).is_some())
                {
                    assert!(proportional.iter().any(|name| name == first.key()), "{language}");
                }
                let characters = ui.fonts_mut(|fonts| fonts.characters(&egui::FontFamily::Proportional).clone());
                assert!(characters.contains_key(&'ก'), "Thai is bundled");
            });
            output.textures_delta.clear();
        }
    }
}
