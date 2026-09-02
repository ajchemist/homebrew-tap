require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/releases/download/v0.3.0/se-sshctl-0.3.0-macos-universal.tar.gz"
  sha256 "5415a613ac0e417005c0819753160ee14f08649e5d8a0355501a42b96760c138"
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
