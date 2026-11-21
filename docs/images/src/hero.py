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
    """This computer: a laptop whose screen shows a tiny version of the picture."""
    out = [f'<ellipse cx="{cx}" cy="{cy+6}" rx="120" ry="92" fill="url(#lg)"/>',
           f'<rect x="{cx-58}" y="{cy-44}" width="116" height="76" rx="8" fill="{C["panel"]}" stroke="{C["text"]}" stroke-width="2.6"/>',
           f'<rect x="{cx-48}" y="{cy-34}" width="96" height="56" rx="4" fill="#13261a"/>',
           f'<path d="M{cx-74} {cy+36}H{cx+74}l-10 11H{cx-64}z" fill="{C["text"]}"/>']
    hub = (cx - 22, cy - 6)
    for i, col in enumerate([C["typ"], C["str"], C["str"], C["str"]]):
        x, y = cx + 26, cy - 6 + (i - 1.5) * 12
        out.append(f'<path d="M{hub[0]} {hub[1]}C{cx} {hub[1]} {cx} {y} {x} {y}" fill="none" stroke="{col}"'
                   f' stroke-width="1.6" opacity=".75"{"" if i == 0 else ' stroke-dasharray="3 3"'}/>'
                   f'<circle cx="{x}" cy="{y}" r="3.6" fill="{col}"/>')
    out.append(f'<circle cx="{hub[0]}" cy="{hub[1]}" r="6" fill="{C["text"]}"/>')
    return "".join(out)


def tailnet(x, y, w, name, domain, color, machines, tag):
    """A tailnet card: its name, its MagicDNS domain and a few of its machines."""
    h = 104
    out = [f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="{C["panel"]}" stroke="{color}" stroke-width="1.8"/>']
    p, _ = t(name, x + 20, y + 33, 19, C["text"], var=BOLD)
    out.append(p)
    p, _ = t(tag, x + w - 18, y + 32, 11.5, color, anchor="end", tracking=.1, var={"wght": 600})
    out.append(p)
    p, _ = t(domain, x + 20, y + 59, 15, color, var={"wght": 500})
    out.append(p)
    mx = x + 20
    for machine, online in machines:
        fill = color if online else "none"
        out.append(f'<circle cx="{mx+5}" cy="{y+81}" r="4.5" fill="{fill}" stroke="{color}" stroke-width="1.6"/>')
        p, tw = t(machine, mx + 16, y + 86, 13, C["text"] if online else C["muted"])
        out.append(p)
        mx += 16 + tw + 18
    return "".join(out), (x, y + h / 2)


def link(x1, y1, x2, y2, color, dashed):
    dash = ' stroke-dasharray="7 7"' if dashed else ""
    mx = (x1 + x2) / 2
    return (f'<path d="M{x1} {y1}C{mx} {y1} {mx} {y2} {x2} {y2}" fill="none" stroke="{color}" stroke-width="2.6"'
            f' stroke-linecap="round"{dash}/>'
            f'<circle cx="{x2}" cy="{y2}" r="4.5" fill="{color}"/>')


# Tailnet names follow Tailscale's own "fun name" pattern, <tail>-<scale>.ts.net,
# with one word from each of the lists in github.com/tailscale/tailscale/tree/main/words.
CARDS = [
    ("Your tailnet", "otter-gecko.ts.net", "typ", "TAILSCALE APP",
     [("ana-laptop", 1), ("phone", 1), ("nas", 1)]),
    ("Home lab", "capybara-iguana.ts.net", "str", "TAILNET LINK",
     [("build-pc", 1), ("pi-hole", 1), ("media-mac", 0)]),
    ("Lantern Studio", "comet-bebop.ts.net", "str", "TAILNET LINK",
     [("wiki", 1), ("db-staging", 1), ("render-02", 0)]),
    ("Client project", "narwhal-koi.ts.net", "str", "TAILNET LINK",
     [("staging", 1), ("ci-runner", 1)]),
]


def diagram():
    lx, ly = 742, 312
    out = ['<defs><radialGradient id="lg"><stop offset="0" stop-color="#7fcf86" stop-opacity=".16"/>'
           '<stop offset="1" stop-color="#7fcf86" stop-opacity="0"/></radialGradient></defs>']
    out.append(laptop(lx, ly))
    p, _ = t("this computer", lx, ly + 76, 13, C["muted"], anchor="middle", tracking=.06)
    out.append(p)

    x, w, h, gap, y = 900, 332, 104, 18, 66
    for i, (name, domain, color, tag, machines) in enumerate(CARDS):
        card, (ax, ay) = tailnet(x, y + i * (h + gap), w, name, domain, C[color], machines, tag)
        out.append(link(lx + 66, ly - 8 + (ay - ly) * .14, ax - 6, ay, C[color], i > 0))
        out.append(card)
    return "".join(out)


def hero():
    return frame(diagram(), "Tailnet Link",
                 ["Stay on your own tailnet.", "Reach every other one, too."],
                 ["no account switching", "shields up", "Win · Mac · Linux"], "TAILSCALE, MULTIPLIED")


if __name__ == "__main__":
    Path(sys.argv[1]).write_text(hero(), encoding="utf-8", newline="\n")
