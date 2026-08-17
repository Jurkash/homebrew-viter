cask "viter" do
  version "1.0.0"
  sha256 "test_sha_dry_run"

  url "https://github.com/yuriishunkin/viter/releases/download/v#{version}/Viter-v#{version}.zip"
  name "Viter"
  desc "Fan control and thermal monitoring for macOS"
  homepage "https://github.com/yuriishunkin/viter"

  depends_on macos: ">= :sonoma"

  app "Viter.app"

  zap trash: [
    "~/Library/Preferences/com.yuriishunkin.Viter.plist",
  ]
end
