cask "viter" do
  version "1.0.0"
  sha256 "a810249f13a5474aca266cb4bd41bdbbbbddf7aa930989cba0c05276b2a67dff"

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
