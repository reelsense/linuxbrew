class Texlive < Formula
  desc "TeX Live is a free software distribution for the TeX typesetting system"
  homepage "http://www.tug.org/texlive/"
  # tag "linuxbrew"

  url "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
  version "20160305"
  sha256 "f4ad5f49c01173de651b3aa4c0a74eac0166e2f3d341de4f8775d31fe2c136bb"

  option "with-full", "install everything"
  option "with-medium", "install small + more packages and languages"
  option "with-small", "install basic + xetex, metapost, a few languages [default]"
  option "with-basic", "install plain and latex"
  option "with-minimal", "install plain only"

  def install
    scheme = %w[full medium small basic minimal].find {
      |x| build.with? x
    } || "small"

    ohai "Downloading and installing TeX Live. This will take a few minutes."
    ENV["TEXLIVE_INSTALL_PREFIX"] = prefix
    system "./install-tl", "-scheme", scheme, "-portable", "-profile", "/dev/null"

    binarch = bin/"x86_64-linux"
    man1.install Dir[binarch/"man/man1/*"]
    man5.install Dir[binarch/"man/man5/*"]
    bin.install_symlink Dir[binarch/"*"]
  end

  test do
    system "#{bin}/tex", "--version"
  end
end
