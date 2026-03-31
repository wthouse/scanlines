# Installation Guide

This guide covers how to install and set up the Scanlines Hugo theme.

## Prerequisites

### Hugo Extended

This theme requires **Hugo Extended** (not the standard Hugo build) because it uses SCSS/Sass for styling.

#### Check Your Installation

```bash
hugo version
```

Look for `+extended` in the output:
```
hugo v0.120.0+extended linux/amd64 BuildDate=...
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
languageCode = "en-us"
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
hugo server
```

Visit `http://localhost:1313` to see your site.

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
languageCode = "en-us"
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
      vignette = false       # Edge fade + screen curvature
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

    # Table of Contents
    [params.scanlines.toc]
      enabled = true
      collapsible = true
      title = "CONTENTS"

    # Status Line (VT220 25th line)
    [params.scanlines.statusLine]
      enabled = false

    # Layout
    [params.scanlines.layout]
      containerWidth = "1200px"
      contentWidth = "720px"

    # Typography
    [params.scanlines.typography]
      baseFontSize = "16px"
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
- `Glass_TTY_VT220.ttf`
- `FiraCode-Regular.ttf`

### Effects Not Showing

1. Check `params.scanlines.effects.enabled = true`
2. Check `params.scanlines.accessibility.disableEffects` is not `true`
3. Check browser doesn't have reduced motion preference

### Build Errors

1. Ensure Hugo Extended v0.120.0+
2. Run `hugo --cleanDestinationDir`
3. Check for TOML syntax errors

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

## Support

- **Issues**: [GitHub Issues](https://github.com/wthouse/scanlines/issues)
- **Discussions**: [GitHub Discussions](https://github.com/wthouse/scanlines/discussions)

---

Built with [Hugo](https://gohugo.io) | Theme: Scanlines
