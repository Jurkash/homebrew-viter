cask "viter" do
  version "1.0.2"
  sha256 "06b29967d3bc408541a57b697f0c701af292c3212ad6ea9a8aa4f7fd4ee5cade"

  url "https://github.com/Jurkash/homebrew-viter/releases/download/v#{version}/Viter-v#{version}.zip"
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
