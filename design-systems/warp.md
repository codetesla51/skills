# Warp — Style Reference
> obsidian command center — a developer's IDE cockpit where the only glow is a single violet phosphor on matte black, and typography carries every signal

**Theme:** dark

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Warp speaks high-end terminal: obsidian-black canvas, near-total achromatic surfaces, typography doing the heavy lifting, one whisper of violet (#cbb0f7) as quiet functional punctuation. Compact density — tight tracking, small body, narrow gaps — IDE confidence. Custom Matter with extreme negative tracking at display (-0.04em at 56px). Warm off-white text (#faf9f6), never pure white. Pill buttons (33-50px) on neutral fills — no chromatic CTA; hierarchy from filled-vs-ghost contrast. Surfaces rise through gray steps (#121212 → #1e1e1d → #333333), never dramatic shadows.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Obsidian | `#000000` | `--color-obsidian` | Page canvas, nav bg, terminal windows |
| Graphite | `#121212` | `--color-graphite` | Secondary surface, hero backdrops, footer base |
| Onyx | `#1e1e1d` | `--color-onyx` | Elevated cards, panels — first step up |
| Carbon | `#333333` | `--color-carbon` | Nested UI, secondary buttons, tag/badge backgrounds |
| Slate Deep | `#40403f` | `--color-slate-deep` | Highest neutral — hovers, modals, chips |
| Bone | `#faf9f6` | `--color-bone` | Primary text/headlines — warm, never clinical |
| Paper | `#ffffff` | `--color-paper` | Light supporting surface only |
| Ash Light | `#e3e2e0` | `--color-ash-light` | Secondary headings, soft dividers, card borders |
| Ash Mid | `#b4b4b2` | `--color-ash-mid` | Body copy, button text on dark fills |
| Ash | `#868684` | `--color-ash` | Tertiary text, captions, resting nav links, metadata |
| Ash Mute | `#a0a0a0` | `--color-ash-mute` | Sub-heading emphasis where Ash is too dim |
| Iron | `#666469` | `--color-iron` | Lowest-priority text, disabled labels |
| Ink | `#080808` | `--color-ink` | Fine borders, deep text on light fills |
| Phosphor Violet | `#cbb0f7` | `--color-phosphor-violet` | The ONLY chromatic color — icon strokes, code accents, mark highlights, subtle borders. Never filled CTAs; whisper, not shout |

## Tokens — Typography

### Matter — Primary display + UI typeface, geometric sans, engineered proportions. 400 body/nav, 600–700 subheadings/emphasis. Extreme negative tracking large (-0.04em at 56px). Free substitute: Inter or General Sans · `--font-matter`
- **Substitute:** Inter
- **Weights:** 400, 600, 700
- **Sizes:** 10, 12, 13, 14, 16, 18, 20, 24, 32, 40, 42, 56
- **Line height:** 0.96–1.40
- **Letter spacing:** -2.24px at 56px, -1.13px at 42px, -0.8px at 40px, -0.29px at 24px, -0.22px at 20px, -0.18px at 18px, near-zero 14-16px; labels 0.2px–1px at 10px (+0.02–0.1em eyebrows)

### Geist Mono / Matter Mono — Monospace for code, terminal output, technical micro-copy in buttons/tags. Substitutes: JetBrains Mono, IBM Plex Mono, Berkeley Mono · `--font-geist-mono`
- **Weights:** 400 · **Sizes:** 16 · **Line height:** 1.00

### Inter — Long-form fallback (testimonials, support copy) where Matter may not load. Tight tracking (-0.012 to -0.014em) · `--font-inter`
- **Weights:** 400, 500 · **Sizes:** 14, 16

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| eyebrow | — | — | 10px | 1.2 | 2px | `--text-eyebrow` |
| caption | — | — | 12px | 1.2 | 0.12px | `--text-caption` |
| body | — | — | 14px | 1.25 | -0.14px | `--text-body` |
| body-lg | — | — | 16px | 1.33 | -0.18px | `--text-body-lg` |
| subheading | — | — | 18px | 1.2 | -0.18px | `--text-subheading` |
| heading-sm | — | — | 20px | 1.2 | -0.22px | `--text-heading-sm` |
| heading | — | — | 24px | 1.19 | -0.29px | `--text-heading` |
| heading-lg | — | — | 32px | 1.15 | -0.64px | `--text-heading-lg` |
| display | — | — | 42px | 1 | -1.13px | `--text-display` |
| display-lg | — | — | 56px | 0.96 | -2.24px | `--text-display-lg` |

## Tokens — Spacing & Shapes

**Density:** compact

### Spacing Scale

| Name | Value | Token |
|------|-------|-------|
| 4 | 4px | `--spacing-4` |
| 8 | 8px | `--spacing-8` |
| 12 | 12px | `--spacing-12` |
| 16 | 16px | `--spacing-16` |
| 20 | 20px | `--spacing-20` |
| 24 | 24px | `--spacing-24` |
| 32 | 32px | `--spacing-32` |
| 40 | 40px | `--spacing-40` |

### Border Radius

| Element | Value |
|---------|-------|
| tags | 50px |
| cards | 20px |
| icons | 4px |
| links | 7px |
| inputs | 7px |
| buttons | 33px |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 64px
- **Card padding:** 24px
- **Element gap:** 10px

## Components

### Top Navigation Bar
Obsidian bg, 60-72px, flex row. Left: Warp wordmark (12px, white). Center: nav links (Matter 400, 14px, #868684), 24px gaps. Right: ghost 'Contact sales' + filled white pill 'Download for Mac'. No border-bottom, no shadow.

### Announcement Banner
Full-width, 36-40px, centered 'Introducing Oz…' (Matter 400, 12px, #b4b4b2) with violet (#cbb0f7) underlined 'Learn more.' Obsidian bg, 1px #1e1e1d bottom border.

### Filled Pill Button (Primary)
White bg (#ffffff), #080808 text, Matter 600 14px, 33px radius, 20-22px horizontal padding, no border. Hover #e3e2e0, 150ms. Subtle 1px inner highlight.

### Ghost Button (Secondary)
Transparent, 1px #333333 border, #b4b4b2 text, Matter 400 14px, 33px radius, 9px 20px padding. Hover: border #b4b4b2, text #faf9f6.

### Text Link Button
No bg, no border, Matter 400 14px #868684. Hover → #faf9f6 + 1px underline. Inline with product copy.

### Product Showcase Card
20px radius, 1px #1e1e1d border, #000000 bg with subtle internal gradient overlay (0–8% violet tint top-left). Zero padding — screenshot fills card. Caption above: 16px white icon, name (Matter 700, 18px, #faf9f6), description (Matter 400, 14px, #868684), Learn More + button row.

### Testimonial Card
Vertical stack: 200-240px branded banner image on top; black panel below with 24px padding: attribution (Matter 600, 13px, #b4b4b2) + quote (Matter 400, 16px, #faf9f6, 1.38, -0.01em). 7px radius, 1px #1e1e1d border.

### Trusted-By Logo Grid
6 columns desktop, cells 120-160px wide, logos monochrome white 40-50% opacity. 80px cell height, 40px/32px gaps. No borders, no backgrounds.

### Featured Partner Card
20px radius, #121212 bg, 1px #1e1e1d border. White partner logo (Matter 700, 32px) + pill category tag (50px radius, transparent, 1px #333333, Matter 400 10px uppercase 0.1em #b4b4b2).

### Section Heading (Centered)
Centered, Matter 400 (size carries hierarchy), 32-42px, #faf9f6, -0.02 to -0.027em, 1.10-1.15. No eyebrow unless new product. 80px top margin.

### Pill Tag / Category Chip
Transparent bg, 1px #333333 border, Matter 400 10px uppercase 0.1em #b4b4b2. 50px radius, 10-12px horizontal / 4px vertical padding.

### Terminal Preview Window
Full-bleed in product cards. Black bg, Geist Mono 16px. Faux terminal: title bar (3 #333333 dots, #868684 filename), command lines with violet (#cbb0f7) path highlights, output #b4b4b2.

### Icon Glyph (Product Mark)
16-20px square, 4px radius, white or violet stroke/fill. Paired with bold 18px Matter 700 product label.

### Footer Base
Obsidian bg, 64px top / 40px bottom padding. Nav links Matter 400, 12px, #666469, 4-5 columns. Bottom row: 11px #666469 copyright + social icons (white 60%) right-aligned.

## Do's and Don'ts

### Do
- Bone (#faf9f6) for all primary text on dark — never #ffffff
- Negative tracking at display: -2.24px at 56px, -1.13px at 42px, -0.29px at 24px
- 33px action buttons, 50px tags — pill signature
- Matter 400 headlines to 42px; trust size + tracking
- Surface steps #121212 → #1e1e1d → #333333 → #40403f, never drop shadows
- Violet (#cbb0f7) only for icon strokes, code highlights, link accents
- Compact gaps: 10px inline, 8-12px component padding, 64px sections

### Don't
- Don't add a second chromatic accent — 0% colorfulness is the system
- Don't use drop shadows or blur for card separation — flat 1px borders + stepping
- Don't use 700 for body/UI — Matter 400 and 600 only in interface
- Don't use pure white text on dark — warm #faf9f6
- Don't use 9999px buttons — honest 33px on filled actions
- Don't add gradients to backgrounds, buttons, cards — strictly flat
- Don't use non-Matter fonts for headlines/UI; Inter is fallback only

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Obsidian | `#000000` | Canvas, nav, terminals, full-bleed sections |
| 1 | Graphite | `#121212` | Section bgs, body panels, footer base |
| 2 | Onyx | `#1e1e1d` | Cards, panels, testimonial containers |
| 3 | Carbon | `#333333` | Nested UI, secondary buttons, tag outlines |
| 4 | Slate Deep | `#40403f` | Hovers, modals, elevated popovers |

## Elevation

No drop shadows. Flat surface stepping + 1px hairlines (#1e1e1d). IDE-flat, terminal-native.

## Imagery

Product screenshots dominate over lifestyle. Hero: two side-by-side product preview cards (terminal output, data table) — the product IS the hero. Testimonials: full-bleed branded banners with dark quote panels below. No stock, no illustrations, no 3D. Logo grid monochrome white, reduced opacity. Geometric minimal icons, monochrome white with optional violet accent.

## Layout

Full-bleed dark canvas, 1200px centered column. Hero: centered 56px headline over two side-by-side product cards, each with icon + label + description + dual-button caption. Below: 6-column logo grid, 3-column testimonial grid, alternating full-width sections. Top bar nav only. 64px section rhythm, flat borders not dividers. 2- and 3-column card grids; single-column content blocks with wide margins.

## Agent Prompt Guide

Text #faf9f6 · bg #000000 · card #1e1e1d · border #1e1e1d/#333333 · accent #cbb0f7 (icons/code/links only)

1. **Hero**: #000000 bg. Headline Matter 400 56px #faf9f6, -2.24px, 0.96. Two product cards side by side: 16px white glyph, name Matter 700 18px, description Matter 400 14px #868684, ghost button (1px #333333, 33px, #b4b4b2) + filled white pill (#ffffff, #080808, 33px, Matter 600 14px).
2. **Testimonial card**: 7px radius, 1px #1e1e1d border, #1e1e1d bg. 200px branded banner on top. 24px padding below: attribution Matter 600 13px #b4b4b2, quote Matter 400 16px #faf9f6 (-0.18px, 1.38).
3. **Section heading**: centered, Matter 400 42px #faf9f6 (-1.13px, 1.0). 80px top, 64px bottom margin.
4. **Category tag**: 50px radius, 1px #333333, transparent, Matter 400 10px uppercase 1px tracking #b4b4b2. 4px 12px padding.
5. **Logo row**: six columns, 1200px grid, 40px gaps. White logos 50% opacity, 40-50px, 80px cells, no borders.

## CSS Custom Properties

```css
:root {
  --color-obsidian: #000000;
  --color-graphite: #121212;
  --color-onyx: #1e1e1d;
  --color-carbon: #333333;
  --color-slate-deep: #40403f;
  --color-bone: #faf9f6;
  --color-ash-mid: #b4b4b2;
  --color-ash: #868684;
  --color-iron: #666469;
  --color-ink: #080808;
  --color-phosphor-violet: #cbb0f7;
  --font-matter: 'Matter', ui-sans-serif, system-ui, sans-serif;
  --font-geist-mono: 'Geist Mono', ui-monospace, monospace;
  --text-display-lg: 56px;
  --text-display: 42px;
  --radius-buttons: 33px;
  --radius-cards: 20px;
  --radius-tags: 50px;
  --page-max-width: 1200px;
  --section-gap: 64px;
}
```
