cask "viter" do
  version "1.0.10"
  sha256 "419466537c8aaa10034d9c1d72c540ffafc9efd684a9130e3ae5483a2becb720"

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
