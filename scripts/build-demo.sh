#!/usr/bin/env bash
#
# Builds exampleSite into ./public as the theme's public demo — once per color
# scheme, so visitors can see all four phosphors:
#
#   /               amber (P3), the default, full CRT effects
#   /green/         green (P1)          /blue/  blue     /white/  white
#   /plain/         same, effects off — and /<scheme>/plain/ for the others
#
# Eight builds in total: four phosphors x {full effects, effects off}.
#
# Intended as the build command for a Cloudflare Pages project pointed at this
# repository:
#
#   Build command:          bash scripts/build-demo.sh
#   Build output directory: public
#
# SET BASE_URL IN THE PRODUCTION ENVIRONMENT to the address you want indexed:
#
#   BASE_URL = https://scanlines.pages.dev/
#
# Without it the build falls back to CF_PAGES_URL, which is the *deployment*
# hostname — https://<hash>.scanlines.pages.dev/ — a different value on every
# push. The site renders fine, but its canonical tags, feed links and og:url
# then advertise a throwaway address that changes each deploy, which is worse
# for indexing than a stale URL would be. Confirmed on a live deployment, not
# inferred: CF_PAGES_URL is the hash hostname on production builds too, not
# just previews.
#
# Same applies, for the same reason, if you attach a custom domain.
#
# Leaving BASE_URL unset is still the right choice for preview branches, where
# the per-deployment hostname genuinely is the correct base.
#
# On any other CI host — Workers Builds, Netlify, GitHub Actions — BASE_URL is
# required, because CF_PAGES_URL is specific to Pages and nothing else supplies
# an equivalent. The script refuses to build rather than guess (see below).
#
# Runs fine on a laptop too:
#   BASE_URL=http://localhost:8080/ bash scripts/build-demo.sh && \
#     python3 -m http.server 8080 -d public

set -euo pipefail

HUGO_VERSION="${HUGO_VERSION:-0.164.0}"
SCHEMES=(green blue white)          # amber is the default and builds at the root
OUT="${OUT:-public}"

# ---------------------------------------------------------------------------
# Base URL
# ---------------------------------------------------------------------------
# Falling back to localhost on a build host is never right: it produces a site
# that looks fine but whose canonical tags, feed links and Open Graph URLs all
# point at 127.0.0.1. That failure is invisible in the build log and only shows
# up once the site is live, so treat it as an error rather than a default.
# Named explicitly rather than dumping the environment: a build log is a
# semi-public artifact and the environment routinely holds API tokens. Every
# variable below is a flag, branch, SHA or public URL.
CI_VARS=(CF_PAGES CF_PAGES_URL CF_PAGES_BRANCH
         WORKERS_CI WORKERS_CI_BRANCH
         CI GITHUB_ACTIONS NETLIFY VERCEL)

BASE="${BASE_URL:-${CF_PAGES_URL:-}}"
if [ -z "$BASE" ]; then
  if [ -n "${CI:-}${WORKERS_CI:-}${CF_PAGES:-}${GITHUB_ACTIONS:-}" ]; then
    cat >&2 <<'MSG'
ERROR: no base URL, and this looks like a CI build.

  Set BASE_URL in the project's environment variables, e.g.
      BASE_URL = https://scanlines.pages.dev/
MSG
    echo "  Which host this is, judging by the environment:" >&2
    for v in "${CI_VARS[@]}"; do
      [ -n "${!v:-}" ] && printf '      %s=%s\n' "$v" "${!v}" >&2
    done
    cat >&2 <<'MSG'

  CF_PAGES_URL is absent above, and Cloudflare Pages always sets it. So this
  is not a Pages project — most likely Workers Builds, which supplies no URL
  of its own. Setting BASE_URL fixes the build either way.
MSG
    exit 1
  fi
  BASE="http://localhost:1313/"     # interactive/local use only
fi
BASE="${BASE%/}/"                   # exactly one trailing slash
echo "==> base URL: $BASE"

# ---------------------------------------------------------------------------
# Hugo. Two requirements, and a host's preinstalled binary can fail either:
#   * extended — the theme compiles SCSS with toCSS
#   * >= MIN_HUGO — layouts/_markup/ render hooks need the 0.146 template system
# A build image that ships an old extended binary would otherwise get past a
# bare "is it extended?" check and fail later with a confusing template error.
# ---------------------------------------------------------------------------
MIN_HUGO="0.146.0"                  # keep in sync with theme.toml min_version

usable_hugo() {                     # usable_hugo <path> -> 0 if extended and new enough
  local bin="$1" v
  [ -x "$bin" ] || return 1
  "$bin" version 2>/dev/null | grep -q extended || return 1
  v="$("$bin" version 2>/dev/null | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1 | tr -d v)"
  [ -n "$v" ] || return 1
  [ "$(printf '%s\n%s\n' "$MIN_HUGO" "$v" | sort -V | head -1)" = "$MIN_HUGO" ]
}

HUGO_BIN="$(command -v hugo || true)"
if usable_hugo "$HUGO_BIN"; then
  echo "==> using Hugo on PATH"
else
  if [ -n "$HUGO_BIN" ]; then
    echo "==> Hugo on PATH is unusable ($("$HUGO_BIN" version 2>&1 | head -1))"
    echo "    need extended, >= $MIN_HUGO"
  else
    echo "==> no Hugo on PATH"
  fi
  echo "==> downloading Hugo v${HUGO_VERSION} extended"
  tmp="$(mktemp -d)"
  url="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  curl -fsSL "$url" -o "$tmp/hugo.tar.gz"
  tar -xzf "$tmp/hugo.tar.gz" -C "$tmp" hugo
  HUGO_BIN="$tmp/hugo"
  usable_hugo "$HUGO_BIN" || { echo "ERROR: downloaded Hugo is still unusable" >&2; exit 1; }
fi
"$HUGO_BIN" version

# ---------------------------------------------------------------------------
# Scheme switcher, injected through the theme's own documented extension hooks.
# Generated here so exampleSite stays a clean starter config in the repo.
#
# Deliberately split across BOTH hooks rather than putting everything in
# custom_footer.html:
#
#   custom_head.html    the <style>  — inside <head>, render-blocking
#   custom_footer.html  the <nav>    — end of <body>, the only body-level hook
#
# Keeping the CSS in <head> matters more than it looks. From the footer it was
# parsed only after the document had already painted, and what it declares is
# not cheap to apply late: a custom property on :root (global style recalc),
# body{padding-top} (relayout of the whole document) and a fixed, z-indexed bar
# (a new stacking context, and in practice a new compositing layer). A repaint
# of that scope after first paint can visibly change how text is rendered —
# desktop browsers use subpixel antialiasing on uncomposited text and grayscale
# on composited text, so glyph edges pick up and lose colour fringing as layers
# come and go. It showed up as a brief flash of colour on the nav links, on
# desktop only, on the demo site only. Declaring it up front avoids the whole
# post-paint recalc.
# ---------------------------------------------------------------------------
mkdir -p exampleSite/layouts/partials
cat > exampleSite/layouts/partials/custom_head.html <<'HTML'
{{- /* Generated by scripts/build-demo.sh — not part of the theme. */ -}}
<style>
:root { --demo-bar-h: 2.4rem; }
body { padding-top: var(--demo-bar-h); }
.demo-bar{
  position:fixed; top:0; left:0; right:0; z-index:200;
  /* safe centring: a plain "center" makes the overflowing left edge
     unreachable once the bar is wider than the viewport */
  display:flex; align-items:center; justify-content:safe center; gap:.15em;
  height:var(--demo-bar-h); padding:0 var(--spacing-sm);
  background:var(--color-bg-secondary);
  border-bottom:1px solid var(--color-border);
  font-family:var(--font-terminal); font-size:.7rem;
  letter-spacing:.1em; text-transform:uppercase;
  color:var(--color-fg-dim); overflow-x:auto; white-space:nowrap;
}
.demo-bar .demo-label{ margin:0 .4em 0 0; }
.demo-bar .demo-sep{ margin:0 .6em; opacity:.5; }
.demo-bar a{ color:var(--color-fg); text-decoration:none; padding:0 .3em; }
.demo-bar a:hover,.demo-bar a:focus{ color:var(--color-fg-bright); }
.demo-bar a::before{ content:"[ "; color:var(--color-fg-dim); }
.demo-bar a::after{ content:" ]"; color:var(--color-fg-dim); }
.demo-bar a[aria-current="page"]{ color:var(--color-fg-bright); }
.demo-bar a[aria-current="page"]::before{ content:"[*"; }
.demo-bar a[aria-current="page"]::after{ content:"*]"; }
@media print { .demo-bar{ display:none; } body{ padding-top:0; } }
</style>
HTML
cat > exampleSite/layouts/partials/custom_footer.html <<'HTML'
{{- /* Generated by scripts/build-demo.sh — not part of the theme.
       Rendered at the end of <body> (the only body-level hook the theme
       exposes) but pinned to the top of the viewport, so it reads as a demo
       banner rather than a page element. Its CSS lives in custom_head.html.

       Two axes: phosphor and effects. Each link preserves the other axis, so
       switching palette keeps you in the same effects mode and vice versa. */ -}}
{{- $scheme := site.Params.scanlines.colorScheme | default "amber" -}}
{{- $plain  := eq site.Params.scanlines.effects.enabled false -}}
{{- $suffix := cond $plain "plain/" "" -}}
{{- $base   := cond (eq $scheme "amber") "/" (printf "/%s/" $scheme) -}}
{{- /* This page's path within its own variant, so switching keeps your place
       instead of bouncing you to the variant's homepage. Every variant builds
       the same content, so the path always exists on the other side. */ -}}
{{- $here := strings.TrimPrefix site.Home.RelPermalink .RelPermalink -}}
<nav class="demo-bar" aria-label="Demo options">
  <span class="demo-label">Phosphor</span>
  {{- range slice "amber" "green" "blue" "white" }}
  {{- $href := printf "%s%s%s" (cond (eq . "amber") "/" (printf "/%s/" .)) $suffix $here }}
  <a href="{{ $href }}"{{ if eq . $scheme }} aria-current="page"{{ end }}>{{ . }}</a>
  {{- end }}
  <span class="demo-sep" aria-hidden="true">|</span>
  <span class="demo-label">Effects</span>
  <a href="{{ printf "%s%s" $base $here }}"{{ if not $plain }} aria-current="page"{{ end }}>Full</a>
  <a href="{{ printf "%splain/%s" $base $here }}"{{ if $plain }} aria-current="page"{{ end }}>Off</a>
</nav>
HTML
trap 'rm -rf exampleSite/layouts "${THEMES:-}"' EXIT

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------
build() {                            # build <destination> <baseURL> [config...]
  local dest="$1" base="$2"; shift 2
  local args=(--source exampleSite --themesDir "$THEMES"
              --baseURL "$base" --destination "$dest"
              --gc --minify --logLevel info)
  [ "$#" -gt 0 ] && args+=(--config "$1")
  "$HUGO_BIN" "${args[@]}" 2>&1 | tee /tmp/demo-build.log
  if grep -qiE "WARN|deprecated" /tmp/demo-build.log; then
    echo "ERROR: Hugo emitted warnings (see above)" >&2
    exit 1
  fi
}

ROOT="$PWD"
rm -rf "${ROOT:?}/$OUT"

# ---------------------------------------------------------------------------
# Theme lookup. exampleSite sets theme = "scanlines", so Hugo needs a directory
# of that name inside --themesDir. Passing ../.. only works when the checkout is
# itself named "scanlines" (true in GitHub Actions, false on Cloudflare Pages,
# which clones to /opt/buildhome/repo). Build an explicit themes dir instead, so
# the name of the checkout directory doesn't matter.
# ---------------------------------------------------------------------------
THEMES="$(mktemp -d)"
ln -sfn "$ROOT" "$THEMES/scanlines"
echo "==> theme linked at $THEMES/scanlines -> $ROOT"

# Every scheme is built twice: full effects, then effects off at /<scheme>/plain/.
# Parent before child, since the plain build nests inside the scheme's directory.
for scheme in amber "${SCHEMES[@]}"; do
  if [ "$scheme" = amber ]; then dir=""; else dir="$scheme/"; fi

  # ogImage is set here rather than in exampleSite/hugo.toml: that file doubles
  # as the starter config people copy, and hardcoding it there would give every
  # downstream site the theme's own branded share card.
  printf '[params.scanlines]\ncolorScheme = "%s"\nogImage = "/images/social-preview.png"\n' \
    "$scheme" > "/tmp/demo-$scheme.toml"
  echo "==> building $scheme at ${BASE}${dir}"
  build "$ROOT/$OUT/${dir%/}" "${BASE}${dir}" "hugo.toml,/tmp/demo-$scheme.toml"

  printf '[params.scanlines]\ncolorScheme = "%s"\nogImage = "/images/social-preview.png"\n[params.scanlines.effects]\nenabled = false\n' \
    "$scheme" > "/tmp/demo-$scheme-plain.toml"
  echo "==> building $scheme (effects off) at ${BASE}${dir}plain/"
  build "$ROOT/$OUT/${dir}plain" "${BASE}${dir}plain/" "hugo.toml,/tmp/demo-$scheme-plain.toml"
done

# ---------------------------------------------------------------------------
# Cache headers.
#
# Cloudflare Pages defaults every asset to "max-age=0, must-revalidate", which
# for a content-hashed stylesheet is both wasteful and actively harmful. The
# browser has to reach the server before it may use main.min.<hash>.css on
# every single navigation, and must-revalidate forbids falling back to the
# cached copy when that check is slow or fails — so the page renders with
# browser defaults instead. That surfaced as a flash of unstyled blue links on
# the nav, intermittently, and more often after a pause long enough for the
# keep-alive connection to close.
#
# The filename already carries a hash of the contents, so the file can never
# change under a given URL: it is safe to cache permanently. Fonts are not
# fingerprinted, so they get a week rather than a year.
# ---------------------------------------------------------------------------
{
  for scheme in amber "${SCHEMES[@]}"; do
    if [ "$scheme" = amber ]; then dir=""; else dir="$scheme/"; fi
    for p in "$dir" "${dir}plain/"; do
      printf '/%scss/*\n  Cache-Control: public, max-age=31536000, immutable\n' "$p"
      printf '/%sfonts/*\n  Cache-Control: public, max-age=604800\n' "$p"
    done
  done
} > "$ROOT/$OUT/_headers"
echo "==> wrote _headers ($(grep -c 'Cache-Control' "$ROOT/$OUT/_headers") rules)"

echo "==> built $(find "$ROOT/$OUT" -name '*.html' | wc -l) pages into $OUT/"
