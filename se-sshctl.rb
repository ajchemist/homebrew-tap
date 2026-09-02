require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/releases/download/v0.3.0/se-sshctl-0.3.0-macos-universal.tar.gz"
  sha256 "f357930db1d97141910e87553b9dbe085875a193a0936adeb023d7b70eb018cb"
  license "MIT"

  depends_on macos: :tahoe

  def install
    bin.install "se-sshctl"
  end

  test do
    assert_equal "se-sshctl #{version}", shell_output("#{bin}/se-sshctl --version").strip

    report = JSON.parse(shell_output("#{bin}/se-sshctl doctor --json"))
    assert_equal version.to_s, report.fetch("seSSHCTL")
    assert_operator report.fetch("schemaVersion"), :>=, 1
  end
end
