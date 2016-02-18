class Attr < Formula
  desc "Manipulate filesystem extended attributes"
  homepage "https://savannah.nongnu.org/projects/attr"
  url "http://mirror.csclub.uwaterloo.ca/nongnu/attr/attr-2.4.47.src.tar.gz"
  sha256 "25772f653ac5b2e3ceeb89df50e4688891e21f723c460636548971652af0a859"
  # tag "linuxbrew"

  def install
    # Fix No rule to make target `../libattr/libattr.la', needed by `attr'
    ENV.deparallelize

    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install", "install-lib"
  end

  test do
    system bin/"attr", "-l", "/bin/sh"
  end
end
