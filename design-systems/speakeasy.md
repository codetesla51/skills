# Speakeasy — Style Reference
> Editorial broadsheet on a white field with a rainbow ribbon

**Theme:** light

Source measurements are normalized; roles and recommendations are interpreted. Font summary lists are independent, not paired by position. HTML examples are reconstructions, not source components.

Speakeasy is a near-monochromatic editorial system built on a vast white canvas, with one extraordinary move: a custom serif (Tobias) rendered at weight 100, stretched to 140px headlines that whisper rather than announce. The interface feels like a high-end print magazine that accidentally became a product page — generous breathing room, hairline dividers, flat surfaces, and a single vibrant gradient hairline at the page's top edge that acts as a signature ribbon. Color is rationed like ink: black and a warm gray scale do nearly all the work, while small chromatic accents (green, orange, yellow, violet, red) appear as functional punctuation inside icons, badges, and feature illustrations. Components are deliberately flat — borders over shadows, small radii, compact spacing — letting the type and the top rainbow gradient do the brand-building.

## Tokens — Colors

| Name | Value | Token | Role |
|------|-------|-------|------|
| Ink Black | `#000000` | `--color-ink-black` | Dark borders and separators for elevated surfaces and inverted UI. Do not promote it to the primary CTA color |
| Paper White | `#ffffff` | `--color-paper-white` | Page and card surfaces, button text on dark fills, inverse text on black |
| Ash Gray | `#dbdbdb` | `--color-ash-gray` | Default hairline borders, dividers between sections, the most-used neutral border |
| Carbon | `#242424` | `--color-carbon` | Navigation borders, deep surface tone, alt black for softer contrast |
| Graphite | `#545454` | `--color-graphite` | Body text, icon strokes, secondary text, muted UI labels |
| Smoke | `#969696` | `--color-smoke` | Tertiary text, placeholder labels, disabled icon outlines, decorative dot fields |
| Slate | `#7a7a7a` | `--color-slate` | Muted helper text, subtle borders, supporting metadata |
| Bone | `#e7e7e7` | `--color-bone` | Light borders, subtle surface separators, ghost button outlines |
| Iron | `#414141` | `--color-iron` | Icon strokes, dark borders, button shadows, dense text |
| Obsidian | `#333333` | `--color-obsidian` | Filled button background — the system's only CTA fill, paired with white text |
| Mist | `#f1f1f1` | `--color-mist` | Subtle elevated surfaces, off-white section bands, card hover wash |
| Cinder | `#121212` | `--color-cinder` | Deepest text and badge backgrounds, near-black accent |
| Signal Green | `#009966` | `--color-signal-green` | Green outline accent for tags, dividers, and focused UI edges |
| Spring Mint | `#00bc7d` | `--color-spring-mint` | Green wash for highlight backgrounds, decorative bands, and soft emphasis behind content |
| Fern | `#00d492` | `--color-fern` | Soft badge backgrounds, callout fills, gradient end-stop |
| Ember Orange | `#e17100` | `--color-ember-orange` | Icon strokes and feature-card illustrations — the warmest functional accent in iconography |
| Marigold | `linear-gradient(90deg, rgb(51, 15, 31) 0%, rgb(200, 50, 40) 12.56%, rgb(251, 136, 65) 25.06%, rgb(211, 221, 146) 37.56%, rgb(89, 130, 79) 50.06%, rgb(0, 36, 20) 62.06%, rgb(0, 20, 61) 74.06%, rgb(40, 116, 215) 86.06%, rgb(153, 194, 255) 97.06%)` | `--color-marigold` | The signature top-of-page gradient hairline — 9-stop spectrum from maroon through amber, green, indigo, to sky |
| Amber | `#ffb900` | `--color-amber` | Tag/badge backgrounds, warm highlight washes, featured callout fills |
| Coral | `#ff6467` | `--color-coral` | Red outline accent for tags, dividers, and focused UI edges. Use as a supporting accent, not as a status color |
| Iris Blue | `#155dfc` | `--color-iris-blue` | Link and icon accent — the only saturated blue, used sparingly for emphasis strokes |

## Tokens — Typography

### ui-sans-serif (system) — UI chrome — nav labels, buttons, badges, table data, form fields. Small sizes (9–13px) handle the dense secondary UI; 16–18px for button text. Wide tracking (0.05em) on uppercase micro-labels like "THE PROBLEM". · `--font-ui-sans-serif-system`
- **Substitute:** System UI sans (San Francisco / Segoe / Roboto)
- **Weights:** 400, 500, 600, 700
- **Sizes:** 9px, 10px, 11px, 12px, 13px, 14px, 16px, 18px
- **Line height:** 1.43–1.75
- **Letter spacing:** 0.0030em body, 0.0500em uppercase micro-labels
- **OpenType features:** `"calt", "rlig", "ss01"`

### Tobias — Display and headline serif — used at massive sizes (up to 140px) for hero statements, section openers, and oversized editorial moments. The weight-100 thinness is the brand's single most distinctive choice; it makes headlines feel engraved rather than printed. Substitute with a hairline serif (e.g. "GT Super", or "Fraunces 100"). · `--font-tobias`
- **Substitute:** GT Super Thin, Fraunces 100, or any high-contrast hairline serif
- **Weights:** 100
- **Sizes:** 20px, 38px, 51px, 67px, 140px
- **Line height:** 1.00–1.40
- **Letter spacing:** -0.0400em at 51–140px, -0.0200em at 38px
- **OpenType features:** `"calt", "rlig", "ss01"`

### Diatype — Primary body and subheading sans — compact, neutral, engineered for reading. Weight 300 for lighter pull-quotes, 400 for body, 500 for subhead emphasis. Substitute with Inter, Söhne, or Geist. · `--font-diatype`
- **Substitute:** Inter, Söhne, or Geist
- **Weights:** 300, 400, 500
- **Sizes:** 14px, 16px, 18px, 23px, 26px
- **Line height:** 1.29–1.75
- **Letter spacing:** 0.0020em at 14–26px
- **OpenType features:** `"calt", "rlig", "ss01"`

### Type Scale

| Role | Family | Weight | Size | Line Height | Letter Spacing | Token |
|------|--------|--------|------|-------------|----------------|-------|
| caption | — | — | 11px | 1.43 | 0.05px | `--text-caption` |
| body-sm | — | — | 14px | 1.5 | 0.03px | `--text-body-sm` |
| body | — | — | 16px | 1.75 | 0.03px | `--text-body` |
| subheading | — | — | 18px | 1.6 | 0.02px | `--text-subheading` |
| heading-sm | — | — | 23px | 1.38 | 0.02px | `--text-heading-sm` |
| heading | — | — | 38px | 1.3 | -0.76px | `--text-heading` |
| heading-lg | — | — | 51px | 1.2 | -2.04px | `--text-heading-lg` |
| display | — | — | 67px | 1.1 | -2.68px | `--text-display` |

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
| 64 | 64px | `--spacing-64` |
| 80 | 80px | `--spacing-80` |
| 128 | 128px | `--spacing-128` |

### Border Radius

| Element | Value |
|---------|-------|
| tags | 4px |
| cards | 8px |
| badges | 4px |
| buttons | 4px |

### Shadows

| Name | Value | Token |
|------|-------|-------|
| subtle | `rgba(0, 0, 0, 0.1) 0px 1px 3px 0px, rgba(0, 0, 0, 0.1) 0px 1px 2px -1px` | `--shadow-subtle` |
| subtle-2 (filled button) | `rgb(65, 65, 65) 0px 2px 1px 0px inset, rgba(0, 0, 0, 0.05) 0px -2px 1px 0px inset` | `--shadow-subtle-2` |
| subtle-3 (ghost button) | `rgb(255, 255, 255) 0px 2px 1px 0px inset, rgba(0, 0, 0, 0.1) 0px -2px 1px 0px inset` | `--shadow-subtle-3` |
| md (floating card) | `rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px` | `--shadow-md` |

### Layout

- **Page max-width:** 1200px
- **Section gap:** 80px
- **Card padding:** 24px
- **Element gap:** 6px

## Components

### Filled Dark Button
Background #333333 (Obsidian), text #ffffff, border 1px solid #333333, border-radius 4px, padding 10px 16px, font 14px ui-sans-serif weight 500, uppercase tracking. Inset shadow gives a pressed-paper tactile feel.

### Outlined Ghost Button
Background transparent, text #333333, border 1px solid #333333, border-radius 4px, padding 10px 16px, font 14px ui-sans-serif weight 500, uppercase tracking. Light inset highlight.

### Top Nav Link
Font 14px ui-sans-serif weight 500, color #242424, no underline. Chevron dropdown indicator in #545454. Active/hover transitions to underline or weight shift — no color change.

### Top Nav Pill Button
Same as Filled Dark Button but in header context, slightly smaller: 12–14px text, 4px radius, 8px 16px padding.

### NEW Badge
Inline label, font 10–11px ui-sans-serif weight 600 uppercase, 0.05em tracking, border 1px solid #dbdbdb, border-radius 4px, padding 2px 6px, text #242424, background #ffffff. Sits inside a pill-shaped announcement row.

### Announcement Pill
Full-width inline row, 1px #dbdbdb border, 4px radius, white background, contains NEW badge + short text link + chevron arrow. Padding 8px 12px. Font 13px ui-sans-serif.

### Section Eyebrow Label
Font 11–12px ui-sans-serif weight 500, uppercase, 0.05em letter-spacing, color #545454, centered or left-aligned (e.g. "THE PROBLEM").

### Display Headline
Tobias weight 100, 51–67px (hero up to 140px), line-height 1.10–1.20, letter-spacing -0.04em, color #000000. The signature element — paper-thin serif at massive scale.

### Feature Card
Background #ffffff, border 1px solid #dbdbdb, border-radius 8px, padding 24px, optional subtle shadow. Small orange icon on top (Iris Blue or Ember Orange stroke 1.5–2px), 18px Diatype subhead, 14–16px body in #545454. Three-column grid.

### Logo Cloud Cell
No container — logos float on #ffffff canvas in a single horizontal row, grayscale (#545454 to #969696), 32–48px gaps, shared baseline.

### Halftone Illustration
Vector illustration as halftone dot field in #545454 or #969696 — large visual element beside hero text or between sections. No container — the dot field IS the shape.

### Stacked 3D Layer Diagram
Three or more isometric rectangular layers in different pastel tints (lavender, butter yellow, white), small icon + uppercase label on each face. No border, no shadow.

### Rainbow Ribbon Bar
Signature 3px-tall gradient hairline at the very top of every page. Full viewport width, 9-stop linear gradient (maroon → red → amber → yellow-green → green → deep green → indigo → blue → sky blue). Flush against the viewport top, above the nav.

### Agent View FAB
Floating action button, bottom-right persistent chat trigger. Background #ffffff, border 1px solid #dbdbdb, border-radius 9999px, padding 8px 14px, font 12px ui-sans-serif weight 500, fixed at 16px 16px inset, subtle drop shadow. Small icon + 'Agent view' label.

## Do's and Don'ts

### Do
- Use Tobias at weight 100 for all display and hero headlines — never a bold serif; thinness is the brand
- Set filled CTA backgrounds to #333333 (Obsidian) with white text and 4px radius — the only action color
- Define separators with 1px solid #dbdbdb borders, not shadows
- Place the 9-stop rainbow gradient as a 3px hairline at the absolute top of every page
- Pair Diatype body (400) with Tobias headlines (100) — weight contrast is the engine
- Reserve chromatic colors (Signal Green, Ember Orange, Iris Blue, Marigold) for icons, badges, small status indicators — never large fills
- Uppercase ui-sans-serif at 11–12px with 0.05em tracking for all section eyebrows

### Don't
- Do not bolden Tobias headlines above 100 — the hairline is the entire point
- Do not use chromatic fills for primary buttons — CTA stays neutral #333333
- Do not stack drop shadows for card depth — 1px #dbdbdb border instead, or nothing
- Do not use chromatic accents as large backgrounds — icons and small tags only
- Do not set body below 14px or above 18px in Diatype — 14–18px is the reading zone
- Do not replace the rainbow ribbon with a single-color or duotone bar — full spectrum is the signature
- Do not introduce a second serif or competing display face — Tobias owns the editorial space

## Surfaces

| Level | Name | Value | Purpose |
|-------|------|-------|---------|
| 0 | Canvas | `#ffffff` | Default page background — pure white |
| 1 | Raised | `#f1f1f1` | Subtle elevated sections, hover wash, secondary bands |
| 2 | Divider | `#dbdbdb` | Hairline border tone, subtle gray bands |
| 3 | Accent Wash | `#ffb900` | Highlight backgrounds, tag fills, callout panels |
| 4 | Inverse | `#333333` | CTA button surface — the only dark fill |

## Elevation

- **Button (filled):** inset pressed-paper stack
- **Button (light):** inset light stack
- **Floating Card:** `rgba(0, 0, 0, 0.1) 0px 10px 15px -3px, rgba(0, 0, 0, 0.1) 0px 4px 6px -4px`
- **Subtle Surface:** `rgba(0, 0, 0, 0.1) 0px 1px 3px 0px, rgba(0, 0, 0, 0.1) 0px 1px 2px -1px`

## Imagery

Sparse and editorial. Dominant motif: halftone dot illustration — vector shapes rendered as dot fields in #545454 to #969696, no container or frame, atmospheric scale-anchors next to hero text. Product moments: minimal isometric layered illustrations in pastel tints with tiny label chips. No photography. Logos flat grayscale (#545454). Thin-stroke (1.5–2px) line icons, often Ember Orange or Iris Blue, 20–24px in feature cards. Low image-to-text ratio — typography dominates.

## Layout

Max-width 1200px centered column on full-bleed white canvas. Hero two-column split: left eyebrow + display headline + body + dual CTAs (filled + ghost), right large halftone illustration. Repeating section rhythm: (1) thin #dbdbdb divider, (2) centered single-column statement with oversized Tobias headline, (3) 3-column card grid, (4) two-column split (text + isometric illustration). 80px section gaps. Single thin top bar — logo left, links center, utility + CTA right — below the 3px rainbow ribbon. Persistent 'Agent view' FAB bottom-right at 16px inset. Alternating full-width and contained 1200px sections, no sidebar.

## Agent Prompt Guide

Text #000000 · Background #ffffff · Border #dbdbdb · Muted #545454 · Filled button #333333 (white text)

1. **Hero section**: White bg. 67px Tobias weight 100 headline #000000, -2.68px tracking. Body 16px Diatype 400 #545454. Filled dark button (#333333, white text, 4px radius, 10px 16px, 14px/500 uppercase) + outlined ghost button (same dims). 1px #dbdbdb announcement pill above headline with NEW badge.
2. **Feature card grid**: Three columns, 24px gap, 24px padding. White bg, 1px #dbdbdb border, 8px radius. 24px line icon in Ember Orange (#e17100) 1.5px stroke. Subhead 18px Diatype 500 #000000, body 16px Diatype 400 #545454. No shadow.
3. **Section eyebrow + display headline**: Centered stack. Eyebrow 12px/500 uppercase, 0.05em, #545454. Headline 51px Tobias 100, -2.04px, #000000, 1.20. Body 16px Diatype 400 #545454, max-width 640px.
4. **Logo cloud row**: Full-width band, 1px #dbdbdb top/bottom borders, white bg. 8 logos one row, grayscale (#545454), 48px gap, vertically centered, no captions.
5. **Stacked layer diagram**: Right column, two-column section. 4 isometric layers, -15deg Y rotation, 8px vertical gaps. Fills #ede9fe, #fef3c7, #ffffff, #f1f1f1. 10px uppercase #545454 labels + 14px icons. No border, no shadow.

## Type Pairing Logic

Tobias + Diatype pairing engineered around weight inversion: headlines ultra-thin (100), body mid-weight (400) — maximum contrast at minimum visual cost. Diatype 500 subheadings bridge. Third tier — ui-sans-serif chrome (nav, buttons, badges, eyebrows) in 400–500 — never competes with editorial type. Letter-spacing by size: -0.04em at 51px+ Tobias, 0.02–0.03em body, 0.05em uppercase micro-labels. Shared font-feature-settings ("calt", "rlig", "ss01") across all three families.

## CSS Custom Properties

```css
:root {
  --color-ink-black: #000000;
  --color-paper-white: #ffffff;
  --color-ash-gray: #dbdbdb;
  --color-carbon: #242424;
  --color-graphite: #545454;
  --color-obsidian: #333333;
  --color-mist: #f1f1f1;
  --color-signal-green: #009966;
  --color-ember-orange: #e17100;
  --color-amber: #ffb900;
  --color-coral: #ff6467;
  --color-iris-blue: #155dfc;
  --gradient-marigold: linear-gradient(90deg, rgb(51,15,31) 0%, rgb(200,50,40) 12.56%, rgb(251,136,65) 25.06%, rgb(211,221,146) 37.56%, rgb(89,130,79) 50.06%, rgb(0,36,20) 62.06%, rgb(0,20,61) 74.06%, rgb(40,116,215) 86.06%, rgb(153,194,255) 97.06%);
  --font-tobias: 'Tobias', ui-sans-serif, system-ui, sans-serif;
  --font-diatype: 'Diatype', ui-sans-serif, system-ui, sans-serif;
  --text-display: 67px;
  --text-heading-lg: 51px;
  --text-heading: 38px;
  --text-body: 16px;
  --radius-cards: 8px;
  --radius-buttons: 4px;
  --page-max-width: 1200px;
  --section-gap: 80px;
}
```
