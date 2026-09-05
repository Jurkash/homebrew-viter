cask "viter" do
  version "1.1.5"
  sha256 "e580af4fa3c1eae6d5b7f7de4fcb21683c25756d2f84c23899b2a7535ff64b2e"

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
