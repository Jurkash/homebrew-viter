cask "viter" do
  version "1.1.8"
  sha256 "3da92112bac634ee36c356778336590025419e9f5f93680f0e4f2fd581586522"

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
