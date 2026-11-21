"""The README hero and GitHub social preview, in the Azazel Labs card style.

Uses the card generator from the organisation's `.github` repository, checked out
next to this one (or set AZAZEL_BRAND_SRC to its `profile/assets/src` folder):

    FONT_DIR=<folder with Fraunces.ttf, Fraunces-Italic.ttf, JetBrainsMono.ttf> \
        python docs/images/src/hero.py docs/images/hero.svg
    resvg -w 1280 -h 640 docs/images/hero.svg docs/images/social-preview.png

Needs uharfbuzz. Every name in the picture is made up.
"""
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.dont_write_bytecode = True  # keep the brand repo's checkout clean
sys.path.insert(0, os.environ.get("AZAZEL_BRAND_SRC", str(ROOT.parent / ".github" / "profile" / "assets" / "src")))
from cards import C, frame, t  # noqa: E402

BOLD = {"wght": 650}


def laptop(cx, cy):
    """A small laptop glyph centred on (cx, cy)."""
    return (f'<rect x="{cx-46}" y="{cy-34}" width="92" height="60" rx="7" fill="{C["panel"]}" stroke="{C["text"]}" stroke-width="2.4"/>'
            f'<rect x="{cx-37}" y="{cy-25}" width="74" height="42" rx="3" fill="#13261a"/>'
            f'<path d="M{cx-60} {cy+30}H{cx+60}l-8 9H{cx-52}z" fill="{C["text"]}"/>')


def tailnet(x, y, w, name, domain, color, machines, tag):
    """A tailnet card: name, domain and a row of machine dots (filled = online)."""
    h = 92
    out = [f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="{C["panel"]}" stroke="{color}" stroke-width="1.8"/>']
    p, _ = t(name, x + 20, y + 34, 19, C["text"], var=BOLD)
    out.append(p)
    p, _ = t(domain, x + 20, y + 62, 14.5, C["muted"])
    out.append(p)
    p, _ = t(tag, x + w - 18, y + 34, 12, color, anchor="end", tracking=.1, var={"wght": 600})
    out.append(p)
    for i, online in enumerate(machines):
        cx = x + w - 24 - (len(machines) - 1 - i) * 22
        fill = color if online else "none"
        out.append(f'<circle cx="{cx}" cy="{y+62}" r="6.5" fill="{fill}" stroke="{color}" stroke-width="2"/>')
    return "".join(out), (x, y + h / 2)


def link(x1, y1, x2, y2, color, dashed):
    dash = ' stroke-dasharray="7 7"' if dashed else ""
    mx = (x1 + x2) / 2
    return (f'<path d="M{x1} {y1}C{mx} {y1} {mx} {y2} {x2} {y2}" fill="none" stroke="{color}" stroke-width="2.6"'
            f' stroke-linecap="round"{dash}/>'
            f'<circle cx="{x2}" cy="{y2}" r="4.5" fill="{color}"/>')


def diagram():
    out = []
    lx, ly = 760, 318
    out.append(laptop(lx, ly))
    p, _ = t("this computer", lx, ly + 66, 13, C["muted"], anchor="middle", tracking=.06)
    out.append(p)

    cards = [
        ("Your tailnet", "example.ts.net", C["typ"], [1, 1, 1, 0], "TAILSCALE APP", 70, False),
        ("Home lab", "home.example", C["str"], [1, 1, 1], "TAILNET LINK", 196, True),
        ("Lantern Studio", "studio.example", C["str"], [1, 1, 0, 1], "TAILNET LINK", 322, True),
        ("Client project", "client.example", C["str"], [1, 0], "TAILNET LINK", 448, True),
    ]
    x, w = 900, 330
    for name, domain, color, machines, tag, y, dashed in cards:
        card, (ax, ay) = tailnet(x, y, w, name, domain, color, machines, tag)
        out.append(link(lx + 62, ly - 4 + (ay - ly) * .12, ax - 6, ay, color, dashed))
        out.append(card)
    return "".join(out)


def hero():
    return frame(diagram(), "Tailnet Link",
                 ["Stay on your own tailnet.", "Reach every other one, too."],
                 ["no account switching", "shields up", "Win · Mac · Linux"], "TAILSCALE, MULTIPLIED")


if __name__ == "__main__":
    Path(sys.argv[1]).write_text(hero(), encoding="utf-8", newline="\n")
