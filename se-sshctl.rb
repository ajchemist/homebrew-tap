require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "21042ed525e913bd2cc31194a28ea92d12f85a7efc8e129be73a9d2c5b23db92"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/ajchemist/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "10b9f247e261cbcb62eee33721d441e2d7f57b8ef9eb4d6da63a1382195fa960"
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
