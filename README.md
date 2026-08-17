# homebrew-tap

Homebrew Tap for [Viter](https://github.com/yuriishunkin/viter) — fan control and thermal monitoring for macOS.

## Install

```bash
brew tap yuriishunkin/tap
brew install --cask viter
```

Or in one command:

```bash
brew install --cask yuriishunkin/tap/viter
```

## How it works

The `Casks/viter.rb` file in this repository is **automatically updated** by the
[viter release pipeline](https://github.com/yuriishunkin/viter/blob/main/.github/workflows/release.yml)
whenever a new version is tagged. You should not need to edit it manually.
