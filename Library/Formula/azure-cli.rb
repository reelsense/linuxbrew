class AzureCli < Formula
  desc "Official Azure CLI"
  homepage "https://github.com/azure/azure-xplat-cli"
  url "https://github.com/Azure/azure-xplat-cli/releases/download/v0.9.16-March2016/azure-cli.0.9.16.tar.gz"
  sha256 "dc6f41306a98a153889019d25f57a4ae6f0743cf8cb3670693e9bc9a779ca4d6"

  head "https://github.com/azure/azure-xplat-cli.git", :branch => "dev"

  bottle do
    cellar :any_skip_relocation
    sha256 "baf7cf0ddab8b692b9923ef97b5c1d8c1a45172934289f196567d74a882f0778" => :el_capitan
    sha256 "3891d174c3d42b55a30c15a4170bd485ad4534cb288edfe3c3cac3fd1d6da1c8" => :yosemite
    sha256 "1b087de1c323c6479a6b1cb29a2eade0d27c28a14c4d8eac68b5e825fccdf4bc" => :mavericks
  end

  depends_on "node"

  def install
    ENV.prepend_path "PATH", "#{Formula["node"].opt_libexec}/npm/bin"
    # install node dependencies
    system "npm", "install"
    # remove windows stuff
    rm_rf "bin/windows"
    (prefix/"src").install Dir["lib", "node_modules", "package.json", "bin"]
    bin.install_symlink (prefix/"src/bin/azure")
    (bash_completion/"azure").write `#{bin}/azure --completion`
  end

  test do
    json_text = shell_output("#{bin}/azure account env show AzureCloud --json")
    azure_cloud = Utils::JSON.load(json_text)
    assert_equal azure_cloud["name"], "AzureCloud"
    assert_equal azure_cloud["managementEndpointUrl"], "https://management.core.windows.net"
    assert_equal azure_cloud["resourceManagerEndpointUrl"], "https://management.azure.com/"
  end
end
