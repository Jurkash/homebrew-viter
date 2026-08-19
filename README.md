# Viter — Mac fan control and thermal monitoring for Apple silicon

[![Latest version](https://img.shields.io/github/v/release/Jurkash/homebrew-viter?label=version&color=2E9BD6)](https://github.com/Jurkash/homebrew-viter/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/Jurkash/homebrew-viter/total?label=downloads&color=E4B363)](https://github.com/Jurkash/homebrew-viter/releases)
[![macOS 14+](https://img.shields.io/badge/macOS-14%20Sonoma%2B-080C11)](https://viter.app/support.html)
[![Apple silicon](https://img.shields.io/badge/Apple%20silicon-arm64-080C11)](https://viter.app/support.html)
[![Website](https://img.shields.io/badge/viter.app-2E9BD6)](https://viter.app/)

**Viter** is a Mac fan control app: draw a multi-point **fan curve** against any
sensor, hold a **constant RPM**, or hand the fans back to macOS — over every
thermal sensor an Apple silicon Mac exposes through the SMC. It lives in the
menu bar with a live CPU temperature and fan RPM readout, and its panel drops
out of the notch. *Вітер* is Ukrainian for "wind."

Monitoring is free forever, with no account and no telemetry. Fan control is
Viter Pro. This repository is the **public Homebrew tap** and the download host;
the app's source repository is private.

<p align="center">
  <img src="https://viter.app/assets/og.png" alt="Viter on macOS: live thermal readout over a turning impeller" width="820">
</p>

## Install

```bash
brew install --cask Jurkash/viter/viter
```

Or tap first, then install:

```bash
brew tap Jurkash/viter
brew install --cask viter
```

Prefer a disk image? [Download Viter from viter.app](https://viter.app/) or grab
`Viter-vX.Y.Z.dmg` from [Releases](https://github.com/Jurkash/homebrew-viter/releases/latest).
Every build is Developer ID signed, notarized and stapled by Apple, so it opens
with no right-click-to-open ritual.

Upgrading and removing:

```bash
brew upgrade --cask viter          # or let Viter's own update check tell you
brew uninstall --cask viter        # keeps preferences
brew uninstall --zap --cask viter  # removes preferences too
```

If you enabled fan control, remove the privileged helper **before** uninstalling
— Settings › Fan control › Remove…, or `sudo /Applications/Viter.app/Contents/MacOS/Viter --remove-helper`.
Removing it hands every fan back to macOS.

## Requirements

| | |
|---|---|
| Mac | Apple silicon (M1 or later). Intel Macs are not supported |
| macOS | 14 Sonoma or later |
| Disk | About 6 MB |
| Fan control | One administrator authentication, once, to install a privileged helper |
| Monitoring | Nothing at all — no password, no network, no account |

## Which Macs

Viter has no model whitelist. It reads whatever fans and thermal sensors your
Mac's SMC actually reports, and shows each fan's own hardware range beside its
name.

| Mac | What Viter does |
|---|---|
| MacBook Pro (M1–M4 and later) | Both blowers, linked or independent, with per-fan curves |
| Mac mini (M-series) | Its single fan, curve or held speed |
| Mac Studio | Every fan it reports, linked control across them |
| Mac Pro (M-series) | Unified control across all reported fans |
| iMac (M-series) | Same as the other M-series desktops |
| MacBook Air | Fanless — full sensor monitoring, nothing to control |

On a Mac whose SMC exposes no fans, Viter runs a clearly labelled simulated
machine so every screen stays explorable. It is never passed off as real
hardware.

## Three ways to hold a fan

- **Sensor curve** — a 2–6 point curve drawn against any sensor you choose.
  Double-click to add a point, drag it, or nudge it with the arrow keys; the
  live operating point rides the curve as the temperature moves.
- **Constant RPM** — one held speed, with a floor at the manufacturer minimum,
  because a fan cannot hold a speed below it.
- **Auto** — macOS keeps the fan and Viter changes nothing, just reports the
  live RPM. Always one click away, on every screen.

Plus **Boost**: every fan at maximum for a real 60 seconds, counted down, then
whatever was applied before comes back.

## Presets you build yourself (Pro)

A custom preset carries a name, a base curve (Silent, Balanced, Cool, Max — or
one you draw), and two kinds of behaviour on top:

- **Sensor rules** — *when CPU die average rises above 68 °C, run at 3,800 RPM* —
  chained with AND to narrow a condition, or OR for an alternative.
- **Timed bursts** — *every 10 minutes, run at 4,000 RPM for 20 seconds*. A
  purge on a clock rather than a temperature, for the case no rule can express:
  the machine is not hot, and that is the point. A burst is always a floor; it
  raises the fans above the curve, never slows them below it.

You also choose which four presets the menu bar panel offers, and in what order.

## Every sensor your Mac exposes

Every thermal key the SMC reports — on some Macs more than a hundred — grouped
by device rather than listed flat: CPU, GPU, memory, storage, power, battery,
airflow and heatsinks, enclosure. Each row is live, searchable, pinnable and
charted, with its SMC key and a sparkline. When a group's readings all agree to
a tenth of a degree, Viter leads with the ones that say something different and
folds the rest away.

Alongside them: a teardown-accurate **airflow X-ray** of your chassis tinted by
live temperatures, **history charts** over seven ranges from one minute to a
full day, headroom to throttle, package power, and lifetime totals for air moved
and heat carried out.

## Safety, stated plainly

- Writing a fan target requires root. Without the approved helper the SMC
  refuses the write and Viter says so — it never pretends a write succeeded.
- Above 98 °C with a custom configuration applied, Viter hands every fan back to
  macOS and shows a banner naming the temperature, the action, and the affected
  configuration. That backstop cannot be switched off; there is a configurable
  cutoff at 95 °C above it.
- Every command is clamped to the range the fan itself reports.
- Custom targets do not survive sleep or reboot on their own; while a curve is
  applied Viter re-issues the target at each 1 Hz poll.

## Free and Pro

| | Free | Pro |
|---|---|---|
| Every sensor, X-ray, history, totals | ✓ | ✓ |
| Menu bar readout and notch panel | ✓ | ✓ |
| Auto and Max | ✓ | ✓ |
| Sensor curves and held speeds | | ✓ |
| Silent, Balanced, Cool presets | | ✓ |
| Custom presets, sensor rules, timed bursts | | ✓ |

Pro is a monthly or yearly subscription, or a one-time purchase that keeps
working — see [pricing](https://viter.app/pricing.html). One licence, one Mac.
Paddle is the merchant of record.

## Privacy

No telemetry, no analytics, no crash reporting, no account. Monitoring is
entirely offline. The single network request the app makes is licence
verification, which sends the key, an opaque hash standing in for the Mac (never
a serial number), and the Mac's name so seats can be told apart. Pro keeps
working for 14 days between checks. Full text: [viter.app/privacy.html](https://viter.app/privacy.html).

## Screenshots

| The curve | Custom presets |
|---|---|
| <img src="https://viter.app/assets/shots/curve.webp" alt="Multi-point fan curve editor with a live operating point" width="400"> | <img src="https://viter.app/assets/shots/preset.webp" alt="Custom preset with sensor rules and timed bursts" width="400"> |

| Every sensor | The notch band |
|---|---|
| <img src="https://viter.app/assets/shots/sensors.webp" alt="Thermal sensors grouped by device with sparklines" width="400"> | <img src="https://viter.app/assets/shots/widget.webp" alt="Viter wrapped around the notch showing temperature and fan RPM" width="400"> |

## Questions people ask

**Will Viter run on my Mac?** Any Apple silicon Mac on macOS 14 or later. Fan
control needs a Mac with fans; a MacBook Air gets the full sensor side.

**Why does it ask for an administrator password?** Only root may write fan keys,
so Viter installs a small privileged helper — one authentication, Touch ID where
your Mac has it. Its entire vocabulary is four verbs: set a fan's speed, hand a
fan back to macOS, and two health checks.

**Is taking over the fans safe?** Speeds are clamped to each fan's own reported
range, and the 98 °C hand-back is a backstop no setting disables.

**Do my settings survive a reboot?** Turn on "Restore my speeds at login" and
Viter reapplies them; the helper runs as a background service, so control
survives quitting the app.

**Is Viter open source?** No — Viter is a commercial app. This tap and the
release archives are public; the source repository is private.

**Which languages?** Twenty-one: English, German, French, Spanish, Portuguese
(Brazil), Italian, Dutch, Polish, Ukrainian, Czech, Turkish, Swedish, Danish,
Norwegian Bokmål, Chinese (Simplified and Traditional), Japanese, Korean, Hindi,
Indonesian and Vietnamese. Viter follows macOS, including the per-app language
override.

**Something's wrong.** [Support](https://viter.app/support.html) covers control
being unavailable, no fans listed, preset scaling and the diagnostic switches —
or write to support@viter.app.

## About this repository

The private Viter release pipeline publishes each signed disk image in this
repository's Releases and rewrites `Casks/viter.rb` whenever a version is
tagged. Homebrew fetches the versioned asset from GitHub directly, so an install
never depends on viter.app being up. You should not need to edit the cask by
hand.

## Links

[Website](https://viter.app/) ·
[Pricing](https://viter.app/pricing.html) ·
[Support](https://viter.app/support.html) ·
[Privacy](https://viter.app/privacy.html) ·
[Terms](https://viter.app/terms.html) ·
[Releases](https://github.com/Jurkash/homebrew-viter/releases)

## Keywords

`mac fan control` · `macos fan control` · `apple silicon fan control` ·
`m1 m2 m3 m4 fan control` · `macbook pro fan control` · `mac mini fan control` ·
`mac studio fan control` · `smc fan control mac` · `fan curve macos` ·
`fan speed control mac` · `mac cpu temperature monitor` ·
`macos thermal monitoring` · `menu bar temperature app mac` ·
`mac temperature menu bar` · `macbook cooling app` · `quiet macbook fans` ·
`macos notch app` · `homebrew cask fan control` ·
`macs fan control alternative` · `tg pro alternative` · `smcfancontrol alternative`
