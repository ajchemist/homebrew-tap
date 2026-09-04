require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/releases/download/v0.3.1/se-sshctl-0.3.1-macos-universal.tar.gz"
  sha256 "dc6995e6dde26a486ecaffc095323ca6fa251212878499b2c02b3c3a4bad3c9e"
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
