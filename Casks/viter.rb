cask "viter" do
  version "1.0.9"
  sha256 "57e973e719cbcd6f5a3d8e13afae6576521b42492f1346033313f530dc402fff"

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
