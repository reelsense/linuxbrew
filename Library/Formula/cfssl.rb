require "language/go"

class Cfssl < Formula
  desc "CloudFlare's PKI toolkit"
  homepage "https://cfssl.org/"
  url "https://github.com/cloudflare/cfssl/archive/1.2.0.tar.gz"
  sha256 "30301696fa7ab59aca0cf7883ee82b9b42e0e7c0022269f51454b476a9a2edf9"
  head "https://github.com/cloudflare/cfssl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "eaf7ab4cb575473fe5a9bee2f5fe28d8fa0fa1721ecf6a29c8c0bcd7af5a5fb8" => :el_capitan
    sha256 "828599bcc735eb04e77e3a8400f3e1aa41035de41f33a84d65da0dd76b0fe073" => :yosemite
    sha256 "5ad2bb997d85b6b6863e130f32142bf5674ac19169136b62d0109b71e8c46694" => :mavericks
  end

  depends_on "go" => :build
  depends_on "libtool" => :run

  go_resource "golang.org/x/crypto" do
    url "https://github.com/golang/crypto.git",
      :revision => "3760e016850398b85094c4c99e955b8c3dea5711"
  end

  go_resource "github.com/GeertJohan/go.rice" do
    url "https://github.com/GeertJohan/go.rice.git",
      :revision => "0f3f5fde32fd1f755632a3d31ba2ec6d449e387b"
  end

  go_resource "github.com/cloudflare/cf-tls" do
    url "https://github.com/cloudflare/cf-tls.git",
      :revision => "358b61f346ff4384bd2b051a8d1a24c48444e388"
  end

  go_resource "github.com/daaku/go.zipexe" do
    url "https://github.com/daaku/go.zipexe.git",
      :revision => "a5fe2436ffcb3236e175e5149162b41cd28bd27d"
  end

  go_resource "github.com/dgryski/go-rc2" do
    url "https://github.com/dgryski/go-rc2.git",
      :revision => "8a9021637152186df738b1ec376caf2100fef194"
  end

  go_resource "github.com/miekg/pkcs11" do
    url "https://github.com/miekg/pkcs11.git",
      :revision => "4b4363b37cd397baa396bcde75f4b09f40441bd8"
  end

  go_resource "github.com/kardianos/osext" do
    url "https://github.com/kardianos/osext.git",
      :revision => "29ae4ffbc9a6fe9fb2bc5029050ce6996ea1d3bc"
  end

  go_resource "github.com/coreos/go-systemd" do
    url "github.com/coreos/go-systemd.git",
    :revision => "2ed5b5012ccde5f057c197890a2c801295941149"
  end

  def install
    ENV["GOPATH"] = buildpath
    cfsslpath = buildpath/"src/github.com/cloudflare/cfssl"
    cfsslpath.install Dir["{*,.git}"]
    Language::Go.stage_deps resources, buildpath/"src"
    cd "src/github.com/cloudflare/cfssl" do
      system "go", "build", "-o", "#{bin}/cfssl", "cmd/cfssl/cfssl.go"
      system "go", "build", "-o", "#{bin}/cfssljson", "cmd/cfssljson/cfssljson.go"
      system "go", "build", "-o", "#{bin}/mkbundle", "cmd/mkbundle/mkbundle.go"
    end
  end

  test do
    require "utils/json"
    (testpath/"request.json").write <<-EOS.undent
    {
      "CN" : "Your Certificate Authority",
      "hosts" : [],
      "key" : {
        "algo" : "rsa",
        "size" : 4096
      },
      "names" : [
        {
          "C" : "US",
          "ST" : "Your State",
          "L" : "Your City",
          "O" : "Your Organization",
          "OU" : "Your Certificate Authority"
        }
      ]
    }
    EOS
    shell_output("#{bin}/cfssl genkey -initca request.json > response.json")
    response = Utils::JSON.load(File.read(testpath/"response.json"))
    assert_match /^-----BEGIN CERTIFICATE-----.*/, response["cert"]
    assert_match /.*-----END CERTIFICATE-----$/, response["cert"]
    assert_match /^-----BEGIN RSA PRIVATE KEY-----.*/, response["key"]
    assert_match /.*-----END RSA PRIVATE KEY-----$/, response["key"]
  end
end
