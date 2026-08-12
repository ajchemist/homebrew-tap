require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "df39deac96a05265d9ba9221fd7fc54ce484ebc7d0794c9b51daf120a6baa383"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/ajchemist/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "db43a467e57a848709ec22bd418e7c20dd82cad6734fb44872a9c706af8b3148"
  end

  depends_on macos: :tahoe

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/se-sshctl"
  end

  test do
    report = JSON.parse(shell_output("#{bin}/se-sshctl doctor --json"))
    assert_equal 1, report.fetch("schemaVersion")
  end
end
