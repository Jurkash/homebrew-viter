<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/lockup-dark.png">
    <img src="assets/lockup-light.png" alt="Viter — the app icon beside the wordmark, whose i is dotted by the wheat operating point" width="227">
  </picture>
</p>

# Viter — Mac fan control and thermal monitoring for Apple silicon

[![Latest version](https://img.shields.io/github/v/release/Jurkash/homebrew-viter?label=version&color=2E9BD6)](https://github.com/Jurkash/homebrew-viter/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/Jurkash/homebrew-viter/total?label=downloads&color=E4B363)](https://github.com/Jurkash/homebrew-viter/releases)
[![macOS 14+](https://img.shields.io/badge/macOS-14%20Sonoma%2B-080C11)](https://viter.app/support.html)
[![Apple silicon](https://img.shields.io/badge/Apple%20silicon-arm64-080C11)](https://viter.app/support.html)
[![Website](https://img.shields.io/badge/viter.app-2E9BD6)](https://viter.app/)

**Viter** is a Mac fan control app: draw a multi-point **fan curve** against any
sensor, hold a **constant RPM**, or hand the fans back to macOS — over every
thermal sensor an Apple silicon Mac exposes through the SMC. It lives in the
menu bar with a live CPU temperature and fan RPM readout, its panel drops out of
the notch, and a Shortcut or one line in Terminal can drive all of it.
*Вітер* is Ukrainian for "wind."

Monitoring is free forever, with no account and no telemetry. Fan control and
automation are Viter Pro. This repository is the **public Homebrew tap** and the
download host; the app's source repository is private.

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

### First launch — *new in 1.0.13*

Viter opens a short welcome screen with your own sensors reading live, and says
up front that fan control needs a one-time privileged helper. Install it there
with a single administrator prompt, or choose **Not now** and keep monitoring
with nothing to approve. The screen appears once and does not come back; fan
control stays available in Settings whenever you want it.

While fan control is off, a strip above the fan controls says which of four
things is the matter — no helper installed, a helper that is not answering, one
left behind by a different build of Viter, or a fan command the Mac refused — and
its button does the thing that fixes that case. Settings marks the same state on
the helper row (Set up, Not answering, Out of date) until it is resolved.

## Requirements

| | |
|---|---|
| Mac | Apple silicon (M1 or later). Intel Macs are not supported |
| macOS | 14 Sonoma or later |
| Disk | About 6 MB |
| Fan control | One administrator authentication, once, to install a privileged helper — offered on first launch, or in Settings whenever you like |
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

## From a terminal, a script or a Shortcut (Pro) — *new in 1.0.13*

Turn on **Settings › From other apps › Control from other apps**, and the
commands the panel offers — Boost, a held speed, one of the four built-in
presets, Auto — can be asked for from outside, along with a status read. Homebrew
puts the `viter` command on your PATH with the app and keeps it up to date;
installed from the disk image instead, Settings shows the one-line `ln -s` to
copy. Viter has to be running for any of it: the app is what applies the command.

```bash
viter boost                          # every fan to maximum for 60 seconds
viter boost --for 5m
viter set --rpm 3800 --for 10m       # hold a speed on every fan
viter set --rpm 4200 --fan 0 --hold  # one fan, until something takes it back
viter preset Silent --for 1h         # Silent · Balanced · Cool · Max
viter auto                           # hand every fan back to macOS, now
viter status                         # one line; --json for a machine to read
viter help
```

Durations are `5s`, `90s`, `10m`, `2h`, or a bare number of seconds, from one
second to a day. **A command lasts 60 seconds unless you say otherwise, and the
fans go back to whatever was applied before when it runs out** — a script that
dies half way through cannot leave your Mac pinned at 6,000 RPM. `--hold` is how
you ask for the opposite, and even then Auto or a click in the app takes it back.
An out-of-range duration is refused rather than quietly clamped.

Shortcuts, Automator and anything else that can open a URL use the same grammar:

```
viter://boost?for=5s
viter://preset?id=Balanced&hold=1
viter://set?rpm=3800&fan=0&for=10m
viter://auto
```

`status` is the one verb the URL door does not carry — nothing on the other end
of a URL is listening for an answer.

For scripting, `viter` exits **0** on success, **1** on a usage mistake, **2**
when Viter is not running (`open -a Viter`), **3** when the command was refused
(no Pro, or the switch is off), **4** when fan control is unavailable on this
Mac, and **5** when the SMC refused the write. Messages come back in your Mac's
language, because the app composes them.

Everything stays on the Mac: the command talks to Viter over a socket only
processes running as you can reach, and Viter applies it exactly as it applies a
click — so the panel tells the truth about what is running, and the safety
cutoffs below cover a speed a script set just as they cover one you chose.

## Every sensor your Mac exposes

Every thermal key the SMC reports — on some Macs more than a hundred — grouped
by device rather than listed flat: CPU, GPU, memory, storage, power, battery,
airflow and heatsinks, enclosure. Each row is live, searchable, pinnable and
charted, with its SMC key and a sparkline. When a group's readings all agree to
a tenth of a degree, Viter leads with the ones that say something different and
folds the rest away.

Alongside them: a teardown-accurate **airflow X-ray** of your chassis tinted by
live temperatures, **history charts** over seven ranges from one minute to a
full day, headroom to throttle, SoC power, and lifetime totals for air moved and
heat carried out.

## Safety, stated plainly

- Writing a fan target requires root. Without the approved helper the SMC
  refuses the write and Viter says so — it never pretends a write succeeded.
- Above 98 °C with a custom configuration applied, Viter hands every fan back to
  macOS and shows a banner naming the temperature, the action, and the affected
  configuration. That backstop cannot be switched off, and a cutoff you can turn
  off sits below it at 95 °C.
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
| Control from Shortcuts, scripts and the command line | | ✓ |

Pro is a monthly or yearly subscription, or a one-time purchase that keeps
working — see [pricing](https://viter.app/pricing.html). A licence covers one
Mac; keys bought earlier with more seats keep them, and Settings shows the count.
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
| <img src="https://viter.app/assets/shots/curve.webp" alt="Viter's fan sheet on the Sensor-based tab: a five-point fan curve over a thermal ramp, bound to CPU die average, with Silent, Balanced, Cool and Max preset chips below" width="400"> | <img src="https://viter.app/assets/shots/preset.webp" alt="Viter's preset editor for a preset named Dust purge: a drawn curve, a timed burst every 10 minutes, and a rule firing at 78 °C" width="400"> |

| Every sensor | The notch band |
|---|---|
| <img src="https://viter.app/assets/shots/sensors.webp" alt="Viter's Sensors tab grouped as CPU, GPU, Memory, Storage and Power, each row with its SMC key, a sparkline and a live temperature" width="400"> | <img src="https://viter.app/assets/shots/widget.webp" alt="Viter's notch widget: a black band wrapping the notch showing the impeller mark, a thermal rail, 68 °C and 2,180 RPM" width="400"> |

## Questions people ask

**Will Viter run on my Mac?** Any Apple silicon Mac on macOS 14 or later. Fan
control needs a Mac with fans; a MacBook Air gets the full sensor side.

**Why does it ask for an administrator password?** Only root may write fan keys,
so Viter installs a small privileged helper — one authentication, Touch ID where
your Mac has it. Its whole vocabulary is setting a fan's speed, handing a fan
back to macOS, and answering which build it is and whether it is alive: no shell,
no paths, no arbitrary SMC keys.

**Can other apps drive Viter?** Yes, with Pro: turn on Control from other apps in
Settings, then use a `viter://` URL in a Shortcut or the `viter` command in
Terminal — boost, hold an RPM, apply a preset, return to Auto, or read status. It
stays local to your Mac, and a timed command hands the fans back when it expires.

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
`mac fan control cli` · `fan control from terminal macos` ·
`macos shortcuts fan control` · `macos notch app` · `homebrew cask fan control` ·
`macs fan control alternative` · `tg pro alternative` · `smcfancontrol alternative`
