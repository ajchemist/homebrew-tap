require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "21042ed525e913bd2cc31194a28ea92d12f85a7efc8e129be73a9d2c5b23db92"
  license "MIT"

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
