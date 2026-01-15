---
title: "The DEC VT220: A Terminal Icon"
date: 2024-01-05
description: "A look at the DEC VT220 terminal that inspired this theme"
tags: ["history", "hardware", "dec", "vt220"]
toc: true
---

The DEC VT220 holds a special place in computing history. Introduced in November 1983, it became one of the most successful and widely-used video terminals ever produced.

## Technical Specifications

The VT220 was a significant improvement over its predecessors:

| Feature | Specification |
|---------|---------------|
| CPU | Intel 8051 |
| ROM | 24 KB |
| RAM | 16 KB |
| Display | 80x24 or 132x24 |
| Character Matrix | 7x9 in 10x10 cell |
| Refresh Rate | 60 Hz |

## Display Characteristics

### Phosphor Types

The VT220 was available with three phosphor options:

1. **Amber (P3)** - Peak wavelength 602nm
2. **Green (P1)** - Peak wavelength 525nm
3. **White** - Paper white appearance

### Dot Stretching

One clever feature of the VT220 was its "dot stretching" circuit. Due to the slow rise time of the phosphor, single pixels would be nearly invisible. The video circuitry compensated by extending single lit pixels by one pixel to the right.

This created the characteristic bold, blocky appearance of VT220 text.

## Terminal Emulation

The VT220 could emulate several earlier terminals:

- VT52
- VT100
- VT101
- VT102

This backward compatibility made it easy to upgrade from older systems.

## Legacy

The VT220 was produced until June 1998 - a remarkable 15-year production run. Its influence extends far beyond its production dates:

> Modern terminal emulators still support VT220 escape sequences

Many of the conventions established by the VT series terminals are still in use today:

```bash
# ANSI escape codes for colors
echo -e "\033[32mGreen text\033[0m"
echo -e "\033[33mAmber/Yellow text\033[0m"
```

## The Scanlines Connection

This theme draws direct inspiration from the VT220:

- **Color schemes** match actual phosphor colors
- **Typography** uses the Glass TTY VT220 font
- **Visual effects** simulate CRT characteristics
- **80-column layouts** honor the terminal tradition

The amber glow of a VT220 display represents a golden age of computing - when interfaces were simple, focused, and beautiful in their own way.

---

*Want to experience a real VT220? Check out vintage computing communities and museums that preserve these remarkable machines.*
