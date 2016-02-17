class Keybase < Formula
  desc "Command-line interface to Keybase.io"
  homepage "https://keybase.io/"
  url "https://github.com/keybase/client/archive/v1.0.12-0.tar.gz"
  version "1.0.12-0"
  sha256 "b45e25bbe40684c1f58e69bd2a35c2b8f0936477e28b2c54cab9d8783fed0e0e"

  head "https://github.com/keybase/client.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f844504b5290d471138c7a08b93a4d0fe5180c77e5b999050d978219b3957a9f" => :el_capitan
    sha256 "fb2b1d96525f10f606c9abae24f7b958ce8ea86a276858da4000de2a50164d45" => :yosemite
    sha256 "c1f06efd87c24ce6ebdda5420dabc354daa269e6f8f002ebf648483fa44467df" => :mavericks
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    (buildpath/"src/github.com/keybase/client/").install "go"

    system "go", "build", "-a", "-tags", "production brew", "github.com/keybase/client/go/keybase"
    bin.install "keybase"
  end

  test do
    system "#{bin}/keybase", "-standalone", "id", "homebrew"
  end
end
