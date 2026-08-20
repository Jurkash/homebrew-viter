cask "viter" do
  version "1.0.13"
  sha256 "5635dda282f8427b10b22565730d6d7c36733ec5ddcd109787c11f5fa30fa854"

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
