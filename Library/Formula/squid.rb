class Squid < Formula
  desc "Advanced proxy caching server for HTTP, HTTPS, FTP, and Gopher"
  homepage "http://www.squid-cache.org/"
  url "http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.14.tar.xz"
  sha256 "79ec4cdd4f965314e6db8e3f6ddcebf2d24518edd790a68e0bd4d0a7735ace1b"

  bottle do
    sha256 "0cd7c80832c6e12d724d4d2ea4df8407ab8966cd036252e4075c19a8c7890804" => :el_capitan
    sha256 "64d7b33c7e3795b0946d8285748d60e27acab82e41f505da3902860918f08289" => :yosemite
    sha256 "d28a45a1c7d7d8d1be96c485f92ffa676fe0f4e1723e2760ad59fb5a51c19adc" => :mavericks
  end

  depends_on "openssl"

  def install
    # http://stackoverflow.com/questions/20910109/building-squid-cache-on-os-x-mavericks
    ENV.append "LDFLAGS", "-lresolv"

    # For --disable-eui, see:
    # http://squid-web-proxy-cache.1019090.n4.nabble.com/ERROR-ARP-MAC-EUI-operations-not-supported-on-this-operating-system-td4659335.html
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --localstatedir=#{var}
      --sysconfdir=#{etc}
      --enable-ssl
      --enable-ssl-crtd
      --disable-eui
      --enable-pf-transparent
      --with-included-ltdl
      --with-openssl
    ]

    system "./configure", *args
    system "make", "install"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_sbin}/squid</string>
        <string>-N</string>
        <string>-d 1</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}</string>
    </dict>
    </plist>
    EOS
  end

  test do
    # This test should start squid and then check it runs correctly.
    # However currently dies under the sandbox and "Current Directory"
    # seems to be set hard on HOMEBREW_PREFIX/var/cache/squid.
    # https://github.com/Homebrew/homebrew/pull/44348#issuecomment-143477353
    # If you can fix this, please submit a PR. Thank you!
    assert_match version.to_s, shell_output("#{sbin}/squid -v")
  end
end
