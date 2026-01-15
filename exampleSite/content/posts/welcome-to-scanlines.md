---
title: "Welcome to Scanlines"
date: 2024-01-15
description: "An introduction to the Scanlines Hugo theme and its retro terminal aesthetic"
tags: ["hugo", "theme", "retro", "terminal"]
toc: true
---

Welcome to **Scanlines**, a Hugo theme inspired by the classic DEC VT100 and VT220 terminals from the 1970s and 1980s.

## The Inspiration

The DEC VT220 was introduced in November 1983 and became one of the most popular video terminals of its era. Its distinctive amber phosphor display and clean typography made it an icon of the computing age.

### Phosphor Colors

The VT220 was available with three different phosphor options:

1. **Amber (P3)** - The most popular choice, with a warm orange glow
2. **Green (P1)** - The classic "green screen" look
3. **White** - A cooler, more modern appearance

## Features

This theme recreates the terminal experience with modern web technologies:

> All visual effects are CSS-only, with optional minimal JavaScript for enhanced features

### Visual Effects

The CRT effects include:

- **Scanlines** - Simulating the horizontal scan pattern of CRT displays
- **Flicker** - Subtle brightness variations like real 60Hz displays
- **Phosphor Glow** - The characteristic glow of illuminated phosphors
- **Vignette** - Phosphor edge fade with subtle screen curvature

### Code Highlighting

Syntax highlighting works beautifully with the terminal aesthetic:

```python
def hello_terminal():
    """A simple greeting function"""
    print("HELLO, TERMINAL USER")
    print("SYSTEM READY.")
    return 0

if __name__ == "__main__":
    hello_terminal()
```

Or some shell commands:

```bash
# Check system status
uptime
df -h
free -m

# Start the Hugo server
hugo server --disableFastRender
```

## Accessibility

Despite the retro aesthetic, accessibility remains a priority:

- All effects can be disabled via configuration
- Respects `prefers-reduced-motion` system settings
- High contrast mode available
- Semantic HTML throughout
- Proper focus indicators

## Getting Started

To use this theme:

1. Clone the repository
2. Copy the example configuration
3. Customize your settings
4. Start writing!

---

Stay tuned for more posts about retro computing and terminal aesthetics.

```
> END OF TRANSMISSION_
```
