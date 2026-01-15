---
title: "Configuring Color Schemes"
date: 2024-01-10
description: "How to customize the color scheme in the Scanlines theme"
tags: ["configuration", "colors", "customization"]
toc: true
---

The Scanlines theme comes with four historically-accurate color schemes based on actual CRT phosphor types.

## Available Schemes

### Amber (Default)

The amber scheme uses P3 phosphor colors, which emit at approximately 602nm wavelength. This was the most popular choice for the VT220.

```toml
[params.scanlines]
  colorScheme = "amber"
```

| Property | Hex Value |
|----------|-----------|
| Background | `#0D0A00` |
| Foreground | `#FFB000` |
| Accent | `#FF8C00` |

### Green

The classic "green screen" look using P1 phosphor, which emits at approximately 525nm.

```toml
[params.scanlines]
  colorScheme = "green"
```

### Blue

A cooler blue-white scheme based on later monochrome displays.

```toml
[params.scanlines]
  colorScheme = "blue"
```

### White

Paper white terminals, representing later DEC models with white phosphor.

```toml
[params.scanlines]
  colorScheme = "white"
```

## Custom Colors

You can override individual colors within any scheme:

```toml
[params.scanlines.colors]
  foreground = "#FFCC00"
  background = "#1A1000"
  accent = "#FF6600"
  link = "#FFCC00"
  linkHover = "#FFFFFF"
```

## Effect Intensity

Adjust the intensity of visual effects to match your preference:

```toml
[params.scanlines.effects]
  scanlineOpacity = 0.15   # 0.0 - 1.0
  flickerIntensity = 0.15  # 0.0 - 1.0 (0.05 barely visible, 0.15 subtle, 0.4 strong)
  glowIntensity = 0.8      # 0.0 - 2.0
```

## Accessibility

For users who prefer reduced visual effects:

```toml
[params.scanlines.accessibility]
  highContrast = true      # Boost contrast
  reduceMotion = true      # Disable animations
  disableEffects = true    # Turn off all CRT effects
```

These settings will provide a cleaner, more accessible experience while maintaining the terminal aesthetic.
