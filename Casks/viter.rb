cask "viter" do
  version "1.0.7"
  sha256 "1ea3682b1b5504733798bb867d91318bb8250c2fe737f67c60958a46ee6374c1"

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
