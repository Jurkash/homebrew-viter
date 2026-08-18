cask "viter" do
  version "1.0.6"
  sha256 "9ecf178feec1efe2850ed8fc8507d414bcdf6690b7746a0b8e3dfdc9f412e05b"

  url "https://github.com/Jurkash/homebrew-viter/releases/download/v#{version}/Viter-v#{version}.dmg"
  name "Viter"
  desc "Fan control and thermal monitoring for macOS"
  homepage "https://github.com/Jurkash/homebrew-viter"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Viter.app"

  zap trash: [
    "~/Library/Preferences/com.yuriishunkin.Viter.plist",
  ]
end
