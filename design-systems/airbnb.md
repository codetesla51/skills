# Airbnb — Style Reference
> Quiet white gallery wall with one coral-red bookmark

**Theme:** light

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Airbnb operates on a white-canvas, photograph-first vocabulary: nearly every screen is a quiet monochrome frame that lets full-bleed property imagery carry the experience, with a single saturated coral-red accent (Rausch) as the only chromatic punctuation for action. Typography is set in a custom geometric sans (Airbnb Cereal VF) at mostly small, confident sizes — 14px body, 16px UI, 22–28px section titles — with tight negative tracking and generous line-height. Flat, borderless, rounded: 12–14px radii on cards and controls, pill-shaped circular buttons, soft layered shadows only for elevated overlays like the search bar. Everything else relies on whitespace and hairlines rather than chrome.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Rausch | `#ff385c` | `--color-rausch` | Red decorative accent for icons, marks, small graphic details. Do not promote it to the primary CTA color |
| Rausch 600 | `#e00b41` | `--color-rausch-600` | Pressed and dark-state variant of Rausch for hover/active surfaces |
| Hof | `#222222` | `--color-hof` | Primary text, body copy, headings, icon strokes, inverse backgrounds |
| Foggy | `#6a6a6a` | `--color-foggy` | Secondary text, muted labels, helper copy, metadata beneath card titles |
| Grey 500 | `#c1c1c1` | `--color-grey-500` | Disabled text, placeholders, muted icon strokes |
| Bebe | `#ebebeb` | `--color-bebe` | Hairline borders, input underlines, dividers, separator lines |
| Deco | `#dddddd` | `--color-deco` | Muted containers, skeleton placeholders, disabled card states |
| Faint | `#f7f7f7` | `--color-faint` | Page canvas, footer surface, hover states |
| White | `#ffffff` | `--color-white` | Elevated cards, inputs, modals, primary surface |

## Tokens — Typography

### Airbnb Cereal VF — Custom geometric sans. Body 14px/400; UI labels 16px/500; headings 20px/600, 22px/500 (-0.02em), 28px/700 page titles. Activates the 'salt' alternate glyph feature. · `--font-airbnb-cereal-vf`
- **Substitute:** Circular, Inter, or DM Sans
- **Weights:** 400, 500, 600, 700
- **Sizes:** 11px, 12px, 13px, 14px, 16px, 20px, 21px, 22px, 28px
- **Line height:** 1.18–1.43
- **Letter spacing:** Display 22px: -0.0200em; body 20px: -0.0090em; else normal
- **OpenType features:** `"salt" on`

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| caption | — | — | 11px | 1.18 | 0px | `--text-caption` |
| ui | — | — | 16px | 1.25 | 0px | `--text-ui` |
| subheading | — | — | 20px | 1.2 | -0.18px | `--text-subheading` |
| heading-sm | — | — | 22px | 1.18 | -0.44px | `--text-heading-sm` |
| heading | — | — | 28px | 1.43 | 0px | `--text-heading` |

## Tokens — Spacing & Shapes

**Base unit:** 4px · **Density:** compact

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 4 | 4px | `--spacing-4` |
| 8 | 8px | `--spacing-8` |
| 12 | 12px | `--spacing-12` |
| 16 | 16px | `--spacing-16` |
| 20 | 20px | `--spacing-20` |
| 24 | 24px | `--spacing-24` |
| 28 | 28px | `--spacing-28` |
| 32 | 32px | `--spacing-32` |
| 40 | 40px | `--spacing-40` |
| 44 | 44px | `--spacing-44` |
| 48 | 48px | `--spacing-48` |

### Border Radius

| Element | Value |
|---------|-------|
| cards | 12px |
| badges | 9999px |
| inputs | 8px |
| avatars | 9999px |
| buttons | 9999px |
| search-bar | 9999px |

### Shadows

| Name | Value | Token |
|------|-------|-------|
| subtle | `rgba(0,0,0,0.02) 0px 0px 0px 1px, rgba(0,0,0,0.04) 0px 2px 6px 0px, rgba(0,0,0,0.1) 0px 4px 8px 0px` | `--shadow-subtle` |

### Layout

- **Page max-width:** 1440px
- **Section gap:** 48px
- **Card padding:** 12px
- **Element gap:** 12px

## Components

### Search Bar (Floating Capsule)
Full-width capsule (9999px), white surface, three segmented fields (Where, When, Who) with vertical dividers, 16px/500 labels + 14px/400 placeholders in #6a6a6a. Layered shadow stack at 0/2/4/8px. Right-aligned 48px circular Rausch (#ff385c) submit button with white search icon. Max-width ~880px, centered.

### Property Listing Card
12–14px radius, no border, white/transparent bg. Image full card width ~1:1 aspect, 12px radius, heart wishlist icon top-right. Title 14px/500 #222222 one line; metadata 14px/400 #6a6a6a; price 14px/400 #222222 with amount 14px/600. 12px gutter between image and text, no padding.

### Guest Favorite Badge
White pill (9999px), 12px/600 #222222 text, top-left of listing images. Padding ~6px 12px. Subtle shadow.

### Wishlist Heart Button
Circular transparent button (9999px), absolute top-right of card image. Heart stroke white inactive, Rausch (#ff385c) fill active. 48px touch target, ~20px icon.

### Top Navigation Bar
Fixed, white bg, 80px tall. Left: Rausch logo. Center: tab nav (All, Homes, Experiences, Services), icon + label 16px/500, active tab 2px black underline, inactive #6a6a6a. Right: 'Become a host' 14px/500 link, globe icon, circular hamburger (40px, #f7f7f7 bg).

### Circular Nav Button
Round (9999px), 40px, #f7f7f7 bg, #222222 16px icon. Hover #ebebeb.

### Pill Navigation Tab
Icon + label, active 2px black underline, inactive #6a6a6a / active #222222. 16px/500. No background fill.

### Section Title with Arrow
22px/500 #222222 (-0.02em) + right arrow icon at baseline. Right-aligned 40px circular carousel buttons (#f7f7f7 bg, #222222 chevron).

### Carousel Arrow Button
Circular 32px, white bg + subtle shadow, vertically centered. #222222 chevron; disabled #c1c1c1.

### Ghost Outline Button
Transparent bg, 1px #222222 border, #222222 text, 8px radius, 0px 16px padding. 14px/500. Hover #f7f7f7 fill.

### Filled Inverse Button
Solid #222222 bg, white text, 8px radius, 0px 16px padding. 14px/500. For when Rausch would be too loud.

### Category Icon Button
8px radius, icon centered above label. 24px #222222 icon, 12px/400 #6a6a6a label. Transparent, no border.

### Footer Column Link
14px/400 #6a6a6a, no underline. Hover → #222222. Multi-column grid, 12px row gap. Headers 14px/600 #222222.

### Social Icon Link
Circular (9999px) 32px icon-only button, transparent bg, #222222 icon. Horizontal row in footer.

### Language/Currency Selector
Inline text + globe icon, 14px/500 #222222. No bg, no border. Between copyright and social icons.

## Do's and Don'ts

### Do
- Body 14px/400 Hof (#222222), 1.43 line-height — the content backbone
- Rausch (#ff385c) only for logo, search submit, active hearts, one primary action per surface
- Listing images 12px radius, full-bleed to card edge
- 9999px for search bar, pills, hearts, circular buttons; 12px listing cards; 8px ghost buttons
- Section headings 22px/500, -0.0200em tracking
- Canvas #f7f7f7, cards #ffffff — elevation through value contrast
- Imagery full-bleed within card frame, no margins or decorative borders

### Don't
- Don't add accent colors beyond Rausch — 0% colorfulness is deliberate
- Don't shadow listing cards — flat surfaces + whitespace, not elevation
- Don't set body below 12px (11px badges only)
- Don't round inconsistently — 12px/14px cards, 9999px controls
- Don't border listing cards — separation via canvas-vs-card surface
- Don't apply Rausch to text or decoration — action color, not paint
- Don't use 700 for body/metadata — reserved for 28px titles and 21px emphasis

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Canvas | `#f7f7f7` | Page background |
| 1 | Card | `#ffffff` | Listing cards, inputs, nav pills |
| 2 | Muted Surface | `#dddddd` | Skeletons, disabled states |
| 3 | Inverse | `#222222` | Dark surfaces, inverse buttons, overlays |

## Elevation

- **Search bar:** layered `0/2/4/8px` soft stack
- **Elevated overlay (modal, popover):** `0 8px 28px rgba(0,0,0,0.28)`
- **Dropdown / menu:** `0 6px 20px rgba(0,0,0,0.2)`
- **Tooltip:** `0 2px 4px rgba(0,0,0,0.18)`

## Imagery

Photography dominates — full-bleed warm, well-lit property shots, natural grading, 1:1 crop in cards, no margins. Outlined monochrome icons (#222222, ~16–20px) for nav and controls. Logo is the only multicolor graphic. No illustrations, no 3D, no abstract graphics.

## Layout

Full-bleed, no fixed max-width — edge-to-edge with ~40px desktop side padding. Hero IS the floating search capsule on quiet white canvas — no hero image or headline. Vertically stacked horizontal-scroll sections (~320px tall, 48px gaps, 7-up cards with arrow nav). Footer: 3-column link grid on #f7f7f7 + bottom bar (copyright, language/currency, social). Fixed top bar with centered tabs and right utilities.

## Agent Prompt Guide

text #222222 · bg #ffffff/#f7f7f7 · border #ebebeb · muted #6a6a6a · accent #ff385c

1. **Search bar capsule:** white 9999px capsule, max-width 880px, centered on #f7f7f7. Three fields (Where/When/Who): 16px/500 #222222 labels + 14px/400 #6a6a6a placeholders. 48px Rausch circular submit with white icon. Layered 0/2/4/8px shadow.
2. **Listing card:** no border, no shadow, white. 1:1 image, 12px radius, full-bleed. White 'Guest favorite' pill top-left (12px/600). Transparent heart button top-right (white stroke, Rausch fill active). Name 14px/500, metadata 14px/400 #6a6a6a, price 14px/400 with 600 amount + star rating.
3. **Top nav:** fixed 80px white. Left Rausch logo. Center four icon+label tabs (active 2px black underline). Right 'Become a host' link + 40px circular globe + hamburger (#f7f7f7 bg).
4. **Section title + arrows:** 22px/500 #222222 (-0.02em) + arrow icon; right side two 32px white circular chevron buttons.
5. **Footer column:** 3-col grid on #f7f7f7. Headers 14px/600 #222222, links 14px/400 #6a6a6a, 12px rows, hover → #222222.

## CSS Custom Properties

```css
:root {
  --color-rausch: #ff385c;
  --color-rausch-600: #e00b41;
  --color-hof: #222222;
  --color-foggy: #6a6a6a;
  --color-grey-500: #c1c1c1;
  --color-bebe: #ebebeb;
  --color-deco: #dddddd;
  --color-faint: #f7f7f7;
  --color-white: #ffffff;
  --font-airbnb-cereal-vf: 'Airbnb Cereal VF', ui-sans-serif, system-ui, sans-serif;
  --text-ui: 16px;
  --text-heading-sm: 22px;
  --text-heading: 28px;
  --page-max-width: 1440px;
  --section-gap: 48px;
  --radius-cards: 12px;
  --radius-buttons: 9999px;
  --radius-search-bar: 9999px;
  --shadow-subtle: rgba(0,0,0,0.02) 0px 0px 0px 1px, rgba(0,0,0,0.04) 0px 2px 6px 0px, rgba(0,0,0,0.1) 0px 4px 8px 0px;
}
```
