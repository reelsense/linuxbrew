class Sonar < Formula
  desc "Manage code quality"
  homepage "http://www.sonarqube.org/"
  url "https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.3.zip"
  sha256 "4e61ee3a01d5e447bcd64357df77e0377325c4a2bb5ceb2cdeb5a5d193443ba5"

  depends_on :java => "1.7+"

  bottle :unneeded

  def install
    # Delete native bin directories for other systems
    rm_rf Dir["bin/{aix,hpux,solaris,windows}-*"]

    rm_rf "bin/macosx-universal-32" unless OS.mac? && !MacOS.prefer_64_bit?
    rm_rf "bin/macosx-universal-64" unless OS.mac? && MacOS.prefer_64_bit?
    rm_rf "bin/linux-x86-32" unless OS.linux? && !MacOS.prefer_64_bit?
    rm_rf "bin/linux-x86-64" unless OS.linux? && MacOS.prefer_64_bit?

    # Delete Windows files
    rm_f Dir["war/*.bat"]
    libexec.install Dir["*"]

    bin.install_symlink Dir[libexec/"bin/*/sonar.sh"].first => "sonar"
  end

  plist_options :manual => "sonar console"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
        <string>#{opt_bin}/sonar</string>
        <string>start</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
    </plist>
    EOS
  end

  test do
    assert_match /SonarQube/, shell_output("#{bin}/sonar status", 1)
  end
end
