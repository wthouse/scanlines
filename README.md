# Scanlines

A retro Hugo theme inspired by the look and feel of classic CRT terminals like the DEC VT220 and VT100. Features historically accurate phosphor color schemes, authentic CRT visual effects, and a clean, minimal design.

**[Live demo](https://wt.house)** · [Installation](INSTALLATION.md) · [Configuration](#configuration-reference) · [Changelog](CHANGELOG.md) · [Contributing](CONTRIBUTING.md)

![Scanlines theme - Blog homepage](https://raw.githubusercontent.com/wthouse/scanlines/main/images/homepage_blog.png)

## Features

- **Authentic CRT Effects** - Scanlines, phosphor glow, screen flicker, vignette, and screen curvature
- **Historical Color Schemes** - Amber (P3), Green (P1), Blue, and White phosphor emulation
- **VT220 Status Line** - Fixed 25th-line status bar with blinking cursor
- **ASCII Art Header** - Load custom ASCII art from a file for your site title
- **Two Homepage Modes** - Blog (recent posts) or Profile (landing page with buttons)
- **Responsive Design** - Mobile-first with collapsible navigation and TOC
- **Syntax Highlighting** - Chroma integration with monochrome or colored modes
- **SEO Optimized** - Semantic HTML, meta tags, Open Graph, Twitter cards, JSON-LD structured data, RSS
- **Fully Configurable** - All options namespaced under `params.scanlines`
- **No External Dependencies** - Self-hosted WOFF2 fonts and assets
- **No JavaScript** - Pure CSS effects and interactions
- **Translatable** - All UI strings run through Hugo's i18n system (ships `i18n/en.toml`)
- **Render Hooks** - Lazy-loaded images, heading permalinks, and external links that open in a new tab
- **Accessibility** - Respects `prefers-reduced-motion`, configurable contrast, VT220-style reverse-video focus

## Quick Start

```bash
# Initialize Hugo module (if not already)
hugo mod init github.com/your-username/your-site
```

Add to your `hugo.toml`:

```toml
[module]
  [[module.imports]]
    path = "github.com/wthouse/scanlines"
```

```bash
# Download/update the theme and start the server (requires hugo-extended)
hugo mod get -u
hugo server
```

> **Code blocks:** Hugo's default highlighter inlines its own (monokai) colors,
> which clash with the theme. Add `[markup.highlight]` with `noClasses = false`
> to your `hugo.toml` so code uses the theme's terminal styling. See
> [Syntax Highlighting](#syntax-highlighting).

## Requirements

- **Hugo Extended** v0.146.0 or later (SCSS processing; render hooks use the 0.146+ template system)
- **Go** 1.18+ — only for the Hugo Modules install shown above. The submodule,
  clone and ZIP methods in [INSTALLATION.md](INSTALLATION.md) need nothing but Git.
- No other build tools, package managers or CDN requests

## Configuration Reference

All theme options are namespaced under `[params.scanlines]` in your `hugo.toml`.

### Basic Options

```toml
[params.scanlines]
  # Color scheme: "amber" (default), "green", "blue", "white"
  colorScheme = "amber"

  # Homepage style: "blog" (default) or "profile"
  # "blog"    — site tagline + recent posts
  # "profile" — profile header + buttons (landing page, nav hidden)
  homepage = "blog"

  # Favicon path (relative to static folder)
  favicon = "/favicon.ico"

  # Date format (Go date format string)
  dateFormat = "2006-01-02"

  # Show reading time on posts
  showReadingTime = true

  # Show tags on post listings
  showTags = true

  # Section that holds your posts. The homepage, archive and 404 read from it —
  # change this if your content lives in e.g. content/articles/.
  contentSection = "posts"

  # Default Open Graph / Twitter share image, used when a page sets no `image`.
  # Pages with a `summary_large_image` card need this (or a per-page image).
  ogImage = "/images/og-default.png"

```

### Homepage Modes

**Blog mode** (default): Shows a tagline and recent posts with tags.

**Profile mode**: A landing page with your name, bio, social icons, and configurable buttons. Navigation is hidden — visitors navigate via the buttons you define.

![Profile mode](https://raw.githubusercontent.com/wthouse/scanlines/main/images/homepage_profile.png)

```toml
[params.scanlines]
  homepage = "profile"

[params.scanlines.profile]
  name = "Your Name"
  subtitle = "Your Title"
  avatar = "/images/avatar.png"  # Optional
  bio = "A brief bio about yourself."

  # Buttons shown on profile homepage
  [[params.scanlines.profile.buttons]]
    name = "Posts"
    url = "/posts/"
  [[params.scanlines.profile.buttons]]
    name = "About"
    url = "/about/"
```

### Custom Colors

Override the default color scheme with custom hex values:

```toml
[params.scanlines.colors]
  foreground = "#FFB000"
  background = "#0D0A00"
  backgroundSecondary = "#1A1400"
  accent = "#FF8C00"
  link = "#FFB000"
  linkHover = "#FFD966"
```

### CRT Visual Effects

```toml
[params.scanlines.effects]
  enabled = true           # Master toggle for all effects
  scanlines = true         # Horizontal scanline overlay
  scanlineOpacity = 0.4    # 0.0 - 1.0
  flicker = false          # Screen flicker animation
  flickerIntensity = 0.03  # 0.0 - 1.0 (0.03 barely visible, 0.15 subtle)
  vignette = true          # Phosphor edge fade + subtle screen curvature
  vignetteIntensity = 0.8  # 0.0 - 1.0
  glow = true              # Text phosphor glow
  glowIntensity = 0.8      # 0.0 - 2.0
```

When CRT effects are enabled, images in articles get a partial-grayscale phosphor
treatment so photos sit naturally on the terminal background; hovering eases the
filter back (it doesn't fully restore the original colors). The additional
scanline overlay applies to images wrapped in a `<figure>` — i.e. those inserted
with Hugo's `figure` shortcode. Plain markdown images (`![alt](src)`) get the
grayscale treatment and lazy loading, but no overlay.

### Accessibility

```toml
[params.scanlines.accessibility]
  highContrast = false      # Boost contrast levels
  reduceMotion = false      # Disable all animations
  disableEffects = false    # Turn off all CRT effects entirely
```

The theme also respects the `prefers-reduced-motion` media query automatically:
every animation (screen flicker, scanline drift, the status-line cursor blink,
smooth scrolling) stops. Static effects — scanlines, vignette, glow — stay
visible, since they don't move; use `disableEffects` to remove those too.

### Header

```toml
[params.scanlines.header]
  showTitle = true                  # Show site title or ASCII art (default: true)
  asciiFile = "ascii-header.txt"  # ASCII art file in static/ (leave empty for plain text title)
  showBox = true                  # Show border around header (default: true)
  asciiScale = 1.0                # Multiplier for ASCII art size (1.5 = 50% larger)
```

To use ASCII art, create a text file in your `static/` folder (e.g., `static/ascii-header.txt`). If no file is set, the site title displays as plain text.

### Table of Contents

```toml
[params.scanlines.toc]
  enabled = true
  collapsible = true        # Collapsible toggle
  title = "CONTENTS"
```

Posts show a TOC by default when they have headings; other pages (e.g.
`/about/`) opt in with `toc: true` front matter. A page-level `toc: false`
always hides it.

### Status Line

The VT220's signature 25th line, shown as a fixed bar at the bottom of the screen. Displays site title, current section, and contextual info (reading time, post count, or phosphor type). Hidden on mobile.

```toml
[params.scanlines.statusLine]
  enabled = true
```

### Layout

```toml
[params.scanlines.layout]
  containerWidth = "1200px"   # Max width of the container
  contentWidth = "720px"      # Max width of the content area (~80 columns)
```

### Typography

```toml
[params.scanlines.typography]
  baseFontSize = "20px"       # Base font size (rem units scale from this)
  fontFamily = "glass"        # "glass" (Glass_TTY_VT220) or "fira" (Fira Code)
```

### Syntax Highlighting

Scanlines styles code with Chroma's **class-based** highlighting, which requires
`noClasses = false` in your `hugo.toml`. Without it, Hugo inlines its own
(monokai) colors and the theme's styling — including the `colored` toggle below —
has no effect:

```toml
[markup.highlight]
  noClasses = false           # required: use the theme's syntax styling
  lineNos = true              # optional: show line numbers
  lineNumbersInTable = true   # optional: keeps line numbers selectable
```

```toml
[params.scanlines.syntax]
  colored = false             # false = monochrome (matches theme)
                              # true = multi-color syntax highlighting
```

### Social Links

```toml
[params.scanlines.social]
  github = "wthouse"
  twitter = ""
  linkedin = ""
  mastodon = ""              # Full URL for Mastodon
  medium = ""                # Username (without @)
  hackthebox = ""            # Profile UUID
  bluesky = ""               # Handle (e.g., "you.bsky.social")
  youtube = ""               # Channel handle (without @)
  discord = ""               # User ID
  steam = ""                 # Custom URL ID
  email = "you@example.com"
  rss = true
```

## Page Types

### Home Page
Configurable as either a blog listing or profile landing page (see Homepage Modes above).

### Blog Posts
Create posts in `content/posts/` (or your configured `contentSection`). Supports:
- Inline, collapsible table of contents
- Tags and categories (both render on the post and generate taxonomy pages)
- Reading time
- Post summaries (front-matter `summary` or `description`)

Tags use a `#name` chip; categories use a `/name` chip. Both link to their
taxonomy term pages, which are labelled automatically.

#### Post front matter

Every key is optional. `hugo new posts/my-post.md` starts you off with the
common ones (see `archetypes/posts.md`).

| Key | Type | Effect |
|-----|------|--------|
| `title` | string | Post title — heading, `<title>`, share cards, JSON-LD |
| `date` | date | Publication date. Omit it and the post shows no date in listings |
| `description` | string | Meta description, share-card text, and the listing excerpt. Falls back to the summary |
| `summary` | string | Listing excerpt only. Overrides the auto-generated summary |
| `image` | path | Per-page Open Graph / Twitter image and JSON-LD image. Falls back to `scanlines.ogImage` |
| `author` | string | Overrides `params.author` for this post (byline, `article:author`, JSON-LD) |
| `tags` | list | `#tag` chips + tag term pages |
| `categories` | list | `/category` chips + category term pages |
| `toc` | bool | Force the table of contents on or off. Posts default to on when they have headings; other pages default to off |
| `draft` | bool | Hidden unless you build with `-D` |

### Static Pages
Create pages in `content/` (e.g., `content/about.md`). Set `toc: true` in front
matter to give a long page a table of contents.

### Archive Page
A chronological index of every post, grouped by year. Create `content/archive.md`
and point it at the archive layout:

```yaml
---
title: "Archive"
layout: "archives"
---
```

### 404 Page
Custom VT220-style 404 page with VMS-flavored system messages
(`%SYSTEM-W-NOTFOUND, page not found`) and links back to the homepage and posts.

## Extensibility

### Custom CSS

Create `static/css/custom.css` to add your own styles:

```css
/* Override theme styles */
:root {
  --glow-intensity: 1.5;
}
```

### Custom Head Content

Create `layouts/partials/custom_head.html`:

```html
<link rel="preconnect" href="https://example.com">
<script async src="/js/analytics.js"></script>
```

### Custom Footer Content

Create `layouts/partials/custom_footer.html`:

```html
<script src="/js/custom.js"></script>
```

> This partial renders at the very end of `<body>` — after the site footer and
> the fixed status line, outside the page wrapper. It's the right place for
> scripts, but the wrong place for anything that should appear *inside* an
> article (see Comments below).

## Integrations

The theme ships no JavaScript and makes no external requests. Anything below is
opt-in and supplied by your site — the theme just gives you the hook.

> **Third-party scripts are a trust decision.** The snippets below load code
> from someone else's origin at runtime, so that provider can change what
> executes on your site. Subresource Integrity doesn't help here — these vendors
> ship unversioned, frequently-updated files, and a pinned `integrity` hash
> silently breaks on their next release. If that tradeoff matters to you,
> self-host the script (then you *can* pin a hash), and either way keep the
> origin listed in your [CSP](INSTALLATION.md#content-security-policy).

### Comments

Override `layouts/partials/article-footer.html` in your own site and append your
embed after the existing taxonomy markup, so comments render inside the article
where readers expect them. Copy the theme's version as a starting point:

```bash
cp themes/scanlines/layouts/partials/article-footer.html layouts/partials/
```

```html
<!-- at the end of your copy, inside the closing </footer> -->
{{ if .Params.comments | default true }}
<script src="https://giscus.app/client.js" data-repo="you/your-repo" crossorigin="anonymous" async></script>
{{ end }}
```

Don't use `custom_footer.html` for this — it renders after the status line, so
the widget ends up detached from the post.

### Analytics

Add the snippet to `layouts/partials/custom_head.html` (shown above). Anything
privacy-friendly and self-contained fits the theme's no-external-requests
posture — for example:

```html
<script defer data-domain="example.com" src="https://plausible.io/js/script.js"></script>
```

If you deploy with a strict CSP, remember to allow the origin (see
[INSTALLATION.md](INSTALLATION.md#content-security-policy)).

### Search

There's no built-in search: every client-side option (Fuse.js, Pagefind, Lunr)
ships JavaScript, which the theme deliberately doesn't. Two ways to add it:

- **Zero-JS** — a plain HTML form that hands off to an external engine:

  ```html
  <form action="https://duckduckgo.com/" method="get">
    <input type="hidden" name="sites" value="example.com">
    <input type="search" name="q" aria-label="Search this site">
  </form>
  ```

- **Full-text** — add [Pagefind](https://pagefind.app/) as a post-build step via
  `custom_footer.html`. That does introduce JavaScript to *your* site; the theme
  itself stays clean.

### Math

Hugo renders LaTeX server-side, so math needs no client-side library. Enable the
passthrough extension and add a render hook to your site:

```toml
[markup.goldmark.extensions.passthrough]
  enable = true
  [markup.goldmark.extensions.passthrough.delimiters]
    block  = [['\[', '\]'], ['$$', '$$']]
    inline = [['\(', '\)']]
```

```go-html-template
{{/* layouts/_markup/render-passthrough.html */}}
{{ transform.ToMath .Inner (dict "output" "mathml") }}
```

MathML output needs no stylesheet at all; see the
[Hugo docs](https://gohugo.io/functions/transform/tomath/) for the KaTeX-CSS
variant.

### Translations

All interface strings run through Hugo's i18n system. To translate the theme,
copy the bundled `i18n/en.toml` into your site as `i18n/<lang>.toml`, translate
the values, and set `defaultContentLanguage` in your config. Templates fall back
to English for any missing keys, so partial translations are safe.

## Color Schemes

The theme includes four historically accurate phosphor color schemes. All foreground/background pairs meet WCAG AA for normal text; amber, green, and white also meet AAA.

| Scheme | Phosphor    | Foreground | Background | Contrast |
|--------|-------------|------------|------------|----------|
| Amber  | P3 (~602nm) | `#FFB000`  | `#0D0A00`  | ~12.5:1 (AAA) |
| Green  | P1 (~525nm) | `#33FF66`  | `#001A00`  | ~14.8:1 (AAA) |
| Blue   | Cool white  | `#6AAFFF`  | `#000A1A`  | ~7.7:1 (AAA)  |
| White  | Paper white | `#E6E6E6`  | `#1A1A1A`  | ~13.5:1 (AAA) |

If you set custom colors via `[params.scanlines.colors]`, verify contrast with a tool like [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/). Values are validated against `^#[0-9a-fA-F]{3,8}$` and silently dropped if malformed — invalid hex falls back to the scheme default.

| Green | Blue | White |
|-------|------|-------|
| ![Green](https://raw.githubusercontent.com/wthouse/scanlines/main/images/homepage_profile_green.png) | ![Blue](https://raw.githubusercontent.com/wthouse/scanlines/main/images/homepage_profile_blue.png) | ![White](https://raw.githubusercontent.com/wthouse/scanlines/main/images/homepage_profile_white.png) |

## More Screenshots

| Single Post with TOC | Mobile View |
|---------------------|-------------|
| ![Single post](https://raw.githubusercontent.com/wthouse/scanlines/main/images/single_post.png) | ![Mobile](https://raw.githubusercontent.com/wthouse/scanlines/main/images/mobile_collapsed.png) |

## Fonts

The theme uses two self-hosted fonts:

- **Glass TTY VT220** (default) - Authentic VT220 terminal font (Unlicense)
- **Fira Code** (optional) - Modern monospace alternative (OFL)

## Browser Support

- Chrome/Edge 88+
- Firefox 78+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Android)

## Credits

- Inspired by the [DEC VT220](https://terminals-wiki.org/wiki/index.php/DEC_VT220) terminal
- [Glass TTY VT220 Font](https://github.com/svofski/glasstty) by Viacheslav Slavinsky
- [Fira Code](https://github.com/tonsky/FiraCode) by Nikita Prokopov

### Themes That Inspired This One

- [PaperMod](https://github.com/adityatelange/hugo-PaperMod) by Aditya Telange - Clean layout patterns, profile mode, and archive page design
- [Terminal](https://github.com/panr/hugo-theme-terminal) by Radek Kozieł - Terminal aesthetic and monospace-first typography
- [BOOTSTRA.386](https://github.com/kristopolous/BOOTSTRA.386) by Chris McKenzie - Proof that retro computing aesthetics belong on the modern web
- [Chicago7](https://github.com/akopdev/hugo-theme-chicago7) by Akop Karapetyan - Retro UI inspiration and nostalgic design sensibility

## License

MIT License - see [LICENSE](LICENSE) for details.

---

Built with [Hugo](https://gohugo.io) | Vibed with [Claude Code](https://claude.ai/code) (Claude Opus 4.6)
