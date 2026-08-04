---
title: "Markdown Test Pattern"
date: 2026-06-18
description: "Every markdown element the theme styles, on one page - the SMPTE color bars of a Hugo theme."
summary: "A kitchen-sink page exercising headings, tables, code, images, footnotes, task lists and quotes against the phosphor palette."
tags: ["reference", "markdown", "typography"]
categories: ["Guides"]
toc: true
---

Broadcast engineers had test patterns. This is ours: every markdown element the
theme styles, on one page, so you can see how the phosphor palette handles real
content before committing to it.

## Headings

The heading scale is deliberately shallow - terminals didn't do six weights of
type, and neither does this.

### Third level

#### Fourth level

##### Fifth level

## Text formatting

Body copy is **bold**, *italic*, ***both at once***, ~~struck through~~, and
`inline code`. Links [inside a paragraph](https://gohugo.io) are underlined like
classic hypertext; [external ones](https://github.com/wthouse/scanlines) open in
a new tab. Keyboard shortcuts read naturally as code: `Ctrl` + `C`.

Footnotes work too[^1], including multiple references[^2].

[^1]: Footnotes render at the bottom of the article with a return link.
[^2]: The DEC VT220 shipped in 1983 with a 7×9 character matrix in a 10×10 cell.

## Images

Images get a partial-grayscale phosphor treatment so photographs sit naturally
against the terminal background. Hover to ease the filter back:

![The Scanlines theme rendered in amber](/images/terminal-demo.png)

Images are lazy-loaded automatically by the theme's render hook.

## Blockquotes

> The terminal is the most efficient interface ever devised for talking to a
> computer, and every generation rediscovers this about ten years later.
>
> Nested quotes work as well:
>
> > Including this one, two levels deep.

## Lists

Unordered lists use a `>` prompt marker:

- Phosphor persistence
- Horizontal scan lines
  - Nested items indent cleanly
  - And keep their markers
- Beam brightness falloff at the edges

Ordered lists keep their numerals:

1. Power on, wait for the CRT to warm
2. Watch the raster stabilize
3. Log in

Task lists render with checkboxes:

- [x] Historically accurate phosphor colors
- [x] Pure-CSS effects, zero JavaScript
- [ ] Actual 15 kHz flyback whine

## Tables

| Terminal | Year | Phosphor | Resolution | Notes |
|----------|-----:|----------|-----------:|-------|
| VT52     | 1975 | P4       |     80×24  | The one that started it |
| VT100    | 1978 | P4       |     80×24  | ANSI escape codes |
| VT220    | 1983 | P3 amber |     80×24  | The look this theme copies |
| VT320    | 1987 | P3 amber |    132×24  | Wider text mode |

Tables scroll horizontally on narrow screens rather than breaking the layout.

## Code

Inline `const answer = 42` sits in the text. Fenced blocks get line numbers and
class-based highlighting (requires `noClasses = false`):

```go
// Server renders the terminal session over a websocket.
func handleSession(w http.ResponseWriter, r *http.Request) error {
    conn, err := upgrader.Upgrade(w, r, nil)
    if err != nil {
        return fmt.Errorf("upgrade: %w", err)
    }
    defer conn.Close()

    for {
        if err := pump(conn); err != nil {
            return err
        }
    }
}
```

Different languages, same monochrome treatment:

```sql
SELECT terminal, phosphor, COUNT(*) AS units
FROM   installations
WHERE  year BETWEEN 1983 AND 1987
GROUP  BY terminal, phosphor
ORDER  BY units DESC;
```

```css
/* Set syntax.colored = true for a multi-color palette instead */
.crt-scanlines {
  background: linear-gradient(to bottom, transparent 50%, rgb(0 0 0 / 40%) 50%);
  background-size: 100% 3px;
}
```

With line numbers enabled (as in this demo), an over-long line scrolls
horizontally inside the block, so the numbers stay aligned with their code:

```text
$ dmesg | grep -i tty && echo "this line is deliberately long enough to demonstrate how the theme handles overflow inside a fenced code block on narrow viewports"
```

## Horizontal rules

Rules render as a terminal divider:

---

## Definition-style content

Term lists fall back to standard markup:

**Phosphor persistence**
: How long the coating keeps glowing after the beam moves on. Long persistence
  reduces flicker but smears motion.

**Refresh rate**
: How often the beam repaints the screen - 60 Hz on most DEC terminals.

That's the whole pattern. If everything above reads cleanly in your chosen
scheme, the theme is configured correctly.
