require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "2dd93b3218b90913fc739bfe6b0e0246ab2a1cca9ae6d1bc993b72f5bb3930ef"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/ajchemist/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9f935566d63d822dd2a9c2fa39438c9bada0310d0e632bf41da02be5f1f1af4e"
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
