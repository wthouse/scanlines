# Installation Guide

This guide covers how to install and set up the Scanlines Hugo theme.

## Prerequisites

### Hugo Extended

This theme requires **Hugo Extended** (not the standard Hugo build) because it uses SCSS/Sass for styling.

#### Check Your Installation

```bash
hugo version
```

Look for `+extended` in the output (v0.146.0 or later required):
```
hugo v0.146.0+extended linux/amd64 BuildDate=...
```

#### Installing Hugo Extended

**macOS (Homebrew):**
```bash
brew install hugo
```

**Windows (Chocolatey):**
```bash
choco install hugo-extended
```

**Windows (Scoop):**
```bash
scoop install hugo-extended
```

**Linux (Snap):**
```bash
snap install hugo --channel=extended
```

**From Releases:**
Download the `extended` version from [Hugo Releases](https://github.com/gohugoio/hugo/releases).

## Installation Methods

### Method 1: Hugo Module (Recommended)

> **Requires the Go toolchain** (1.18+). Hugo shells out to `go` for module
> commands — without it `hugo mod init` fails with
> `binary with name "go" not found in PATH`. Install Go from
> [go.dev/dl](https://go.dev/dl/), or use Method 2/3 below, which need only Git.

Initialize your site as a Hugo module (if not already):

```bash
cd your-hugo-site
hugo mod init github.com/your-username/your-site
```

Add to your `hugo.toml`:

```toml
[module]
  [[module.imports]]
    path = "github.com/wthouse/scanlines"
```

Then download the theme:
```bash
hugo mod get -u
```

To update later:
```bash
hugo mod get -u github.com/wthouse/scanlines
```

### Method 2: Git Submodule

```bash
cd your-hugo-site
git submodule add https://github.com/wthouse/scanlines themes/scanlines
```

Add `theme = "scanlines"` to your `hugo.toml`.

To update later:
```bash
git submodule update --remote themes/scanlines
```

### Method 3: Git Clone

```bash
cd your-hugo-site
git clone https://github.com/wthouse/scanlines themes/scanlines
```

Add `theme = "scanlines"` to your `hugo.toml`.

### Method 4: Download ZIP

1. Download the theme from GitHub
2. Extract to `themes/scanlines/`
3. Add `theme = "scanlines"` to your `hugo.toml`

## Basic Configuration

### 1. Update hugo.toml

```toml
baseURL = "https://example.com/"
locale = "en-us"   # Hugo >= 0.158. On older Hugo this key is IGNORED and the
                   # site falls back to lang="en" (no region) — use
                   # languageCode = "en-us" instead if you target < 0.158.
title = "Your Site Title"
theme = "scanlines"  # Not needed if using Hugo Modules

# RSS outputs
[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS"]

# Markup configuration
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = false
  [markup.tableOfContents]
    startLevel = 2
    endLevel = 4
    ordered = false
  [markup.highlight]
    codeFences = true
    noClasses = false
    lineNos = true
    lineNumbersInTable = true

# Navigation menu
# Note: "Posts" link is auto-hidden in blog homepage mode
[menus]
  [[menus.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menus.main]]
    name = "Posts"
    url = "/posts/"
    weight = 2
  [[menus.main]]
    name = "Archive"
    url = "/archive/"
    weight = 3
  [[menus.main]]
    name = "About"
    url = "/about/"
    weight = 4

[params]
  description = "Your site description"
  author = "Your Name"

  # Scanlines theme configuration
  [params.scanlines]
    colorScheme = "amber"

    [params.scanlines.effects]
      enabled = true
      scanlines = true
      glow = true

    [params.scanlines.social]
      github = "wthouse"
      email = "you@example.com"
      rss = true
```

### 2. Create Content Structure

```bash
# Create content directories
mkdir -p content/posts

# Create your first post
hugo new posts/hello-world.md

# Create an about page
hugo new about.md

# Create the archive page
cat > content/archive.md << 'EOF'
---
title: "Archive"
layout: "archives"
---
EOF
```

### 3. Start Development Server

```bash
hugo server -D
```

Visit `http://localhost:1313` to see your site.

> **`-D` includes drafts.** `hugo new` sets `draft: true` in front matter, so
> without `-D` your brand-new post and about page are skipped and the homepage
> reads "No posts yet. Start writing!". Set `draft: false` (or remove the line)
> when a page is ready to publish.

## Directory Structure

After installation, your site should look like:

```
your-site/
├── archetypes/
├── content/
│   ├── posts/
│   │   └── hello-world.md
│   └── about.md
├── layouts/
├── static/
│   └── css/
│       └── custom.css      # Your custom styles (optional)
├── themes/
│   └── scanlines/
├── hugo.toml
└── ...
```

## Full Configuration Reference

Here's a complete `hugo.toml` with all available options:

```toml
baseURL = "https://example.com/"
locale = "en-us"   # Hugo >= 0.158. On older Hugo this key is IGNORED and the
                   # site falls back to lang="en" (no region) — use
                   # languageCode = "en-us" instead if you target < 0.158.
title = "TERMINAL"
theme = "scanlines"

[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS"]

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = false
  [markup.tableOfContents]
    startLevel = 2
    endLevel = 4
    ordered = false
  [markup.highlight]
    codeFences = true
    noClasses = false
    lineNos = true
    lineNumbersInTable = true

[menus]
  [[menus.main]]
    name = "Home"
    url = "/"
    weight = 1
  [[menus.main]]
    name = "Posts"
    url = "/posts/"
    weight = 2
  [[menus.main]]
    name = "Archive"
    url = "/archive/"
    weight = 3
  [[menus.main]]
    name = "About"
    url = "/about/"
    weight = 4

[params]
  description = "Your site description for SEO"
  author = "Your Name"

  [params.scanlines]
    # Color scheme: "amber", "green", "blue", "white"
    colorScheme = "amber"

    # Homepage style: "blog" (default) or "profile"
    homepage = "blog"

    # Misc
    favicon = "/favicon.ico"
    dateFormat = "2006-01-02"
    showReadingTime = true
    showTags = true
    contentSection = "posts"  # Section holding your posts (homepage/archive/404)
    ogImage = ""              # Default Open Graph/Twitter share image

    # Custom color overrides (optional)
    [params.scanlines.colors]
      foreground = ""        # e.g., "#FFB000"
      background = ""        # e.g., "#0D0A00"
      backgroundSecondary = ""
      accent = ""
      link = ""
      linkHover = ""

    # CRT Visual Effects
    [params.scanlines.effects]
      enabled = true         # Master toggle
      scanlines = true       # Horizontal lines
      scanlineOpacity = 0.4  # 0.0 - 1.0
      flicker = false        # Screen flicker
      flickerIntensity = 0.03
      vignette = true        # Edge fade + screen curvature (default: true)
      vignetteIntensity = 0.8
      glow = true            # Phosphor glow
      glowIntensity = 0.8    # 0.0 - 2.0

    # Accessibility
    [params.scanlines.accessibility]
      highContrast = false
      reduceMotion = false
      disableEffects = false

    # Header
    [params.scanlines.header]
      showTitle = true       # Show site title or ASCII art (default: true)
      asciiFile = ""         # ASCII art file in static/ (leave empty for plain text title)
      showBox = true         # Show border around header
      asciiScale = 1.0       # Size multiplier for ASCII art (1.5 = 50% larger, 0.75 = 25% smaller)

    # Table of Contents
    [params.scanlines.toc]
      enabled = true
      collapsible = true
      title = "CONTENTS"

    # Status Line (the VT320-style 25th line)
    [params.scanlines.statusLine]
      enabled = true         # default: true

    # Layout
    [params.scanlines.layout]
      containerWidth = "1200px"
      contentWidth = "720px"

    # Typography
    [params.scanlines.typography]
      baseFontSize = "20px"
      fontFamily = "glass"     # "glass" or "fira"

    # Syntax Highlighting
    [params.scanlines.syntax]
      colored = false

    # Social Links
    [params.scanlines.social]
      github = ""
      twitter = ""
      linkedin = ""
      mastodon = ""
      medium = ""
      hackthebox = ""
      bluesky = ""
      youtube = ""
      discord = ""
      steam = ""
      email = ""
      rss = true

    # Profile (used when homepage = "profile")
    [params.scanlines.profile]
      name = ""
      subtitle = ""
      avatar = ""
      bio = ""

      # Buttons on profile homepage
      # [[params.scanlines.profile.buttons]]
      #   name = "Posts"
      #   url = "/posts/"

```

## Customization

### Custom CSS

Create `static/css/custom.css`:

```css
/* Override theme styles */
:root {
  --glow-intensity: 1.2;
}

.site-title {
  letter-spacing: 0.3em;
}
```

### Custom Head Content

Create `layouts/partials/custom_head.html`:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<script async src="/js/analytics.js"></script>
```

### Custom Footer Content

Create `layouts/partials/custom_footer.html`:

```html
<script src="/js/custom.js"></script>
```

## Troubleshooting

### "TOCSS: failed to transform" Error

You're using standard Hugo instead of Hugo Extended.
Install Hugo Extended version.

### Fonts Not Loading

Check that fonts exist in `themes/scanlines/static/fonts/`:
- `Glass_TTY_VT220.woff2`
- `FiraCode-Regular.woff2`

### Effects Not Showing

1. Check `params.scanlines.effects.enabled = true`
2. Check `params.scanlines.accessibility.disableEffects` is not `true`
3. Check the individual toggle (`scanlines`, `vignette`, `glow`) is not `false`

Note that a reduced-motion preference — the OS setting, or
`accessibility.reduceMotion = true` — stops *animation* only: the screen
flicker, scanline drift, and the blinking status-line cursor. Static scanlines,
vignette and glow stay visible by design. If the flicker specifically is
missing, that's the cause (it's also off by default: set `effects.flicker = true`).

### Build Errors

1. Ensure Hugo Extended v0.146.0+
2. Run `hugo --cleanDestinationDir`
3. Check for TOML syntax errors

## Content Security Policy

The theme emits a small inline `<style>` block when you define
`[params.scanlines.colors]` or layout/typography overrides. If you deploy
with a strict CSP, you'll need `style-src 'self' 'unsafe-inline'` — or
move custom colors into `static/css/custom.css` and omit the overrides
from `hugo.toml`.

A minimal working CSP for a Scanlines-themed site:

```
default-src 'self';
style-src   'self' 'unsafe-inline';
script-src  'self';
img-src     'self' data:;
font-src    'self';
```

The theme bundles no external requests — fonts and CSS are all
self-hosted, so no third-party origins are needed.

## Pagination

The blog list (`/posts/`) and taxonomy pages are paginated. To set the
page size, add to your `hugo.toml`:

```toml
[pagination]
  pagerSize = 10
```

Without a paging config, Hugo's default (10 per page) is used and the
pagination controls render nothing if you have fewer posts than that.

## Updating the Theme

### Hugo Module

```bash
hugo mod get -u github.com/wthouse/scanlines
```

### Git Submodule

```bash
git submodule update --remote themes/scanlines
```

### Git Clone

```bash
cd themes/scanlines
git pull origin main
```

## Deploying

The theme is static output with no build step of its own — any Hugo host works.
Two things matter everywhere:

- **Use the extended Hugo binary, v0.146.0 or later.** Most hosts default to an
  older, non-extended build, which fails with `TOCSS: failed to transform`.
- **`baseURL` must match the final URL**, including any subpath.

### GitHub Pages

Project sites served from a subdirectory (`https://user.github.io/repo/`) are
fully supported — set `baseURL = "https://user.github.io/repo/"` and the theme's
links, favicon, feeds and share images all resolve under the subpath.

```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    branches: [main]
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive   # needed if the theme is a submodule
      - uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: '0.146.0'
          extended: true
      - run: hugo --minify
      - uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

### Cloudflare Pages / Netlify

Set the build command to `hugo --minify`, the output directory to `public`, and
add an environment variable pinning an extended Hugo:

```
HUGO_VERSION = 0.146.0
```

Both platforms read `HUGO_VERSION` and install the extended build. Without the
pin they fall back to an old default and the SCSS pipeline fails.

**Preview deployments:** both hosts build every branch or pull request at a
throwaway URL, but your `baseURL` still points at production, so absolute URLs
in previews (canonical tags, feeds, share images) point at the live site. Each
host exposes the real deployment URL as an environment variable, so you can
override it at build time:

```bash
# Netlify — DEPLOY_PRIME_URL is the current deploy's URL and equals URL in
# production, so this is safe to use unconditionally.
hugo --minify --baseURL "$DEPLOY_PRIME_URL"

# Cloudflare Pages — CF_PAGES_URL is the *.pages.dev address even in
# production, so only override on preview branches. Otherwise a custom domain
# would emit pages.dev canonicals.
if [ "$CF_PAGES_BRANCH" = "main" ]; then
  hugo --minify                                   # baseURL from hugo.toml
else
  hugo --minify --baseURL "$CF_PAGES_URL"
fi
```

## Support

- **Issues**: [GitHub Issues](https://github.com/wthouse/scanlines/issues)

---

Built with [Hugo](https://gohugo.io) | Theme: Scanlines
