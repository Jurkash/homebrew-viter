cask "viter" do
  version "1.0.13"
  sha256 "2044b41aa3a464ed18e49f28b88da144f421ffc06de70edd29f3ee2914e317eb"

  url "https://github.com/Jurkash/homebrew-viter/releases/download/v#{version}/Viter-v#{version}.dmg"
  name "Viter"
  desc "Fan control and thermal monitoring for macOS"
  homepage "https://viter.app/"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Viter.app"
  # The app's own binary, under the name it answers to on the command line.
  # One executable: the same file is the app, the privileged helper, and this.
  binary "#{appdir}/Viter.app/Contents/MacOS/Viter", target: "viter"

  zap trash: [
    "~/Library/Preferences/com.yuriishunkin.Viter.plist",
  ]
end
