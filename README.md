# homebrew-viter

Public Homebrew tap and binary releases for Viter — fan control and thermal monitoring for macOS. The application source repository is private.

## Install

```bash
brew tap Jurkash/viter
brew install --cask viter
```

Or in one command:

```bash
brew install --cask Jurkash/viter/viter
```

## How it works

The private Viter release pipeline publishes an app archive in this
repository's Releases and automatically updates `Casks/viter.rb` whenever a new
version is tagged. You should not need to edit it manually.
