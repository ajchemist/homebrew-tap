require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b379e0246746eeef2d6bf74486c851ed80f81554cdb5ebefa80db9fed83ae3e9"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/ajchemist/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d96eea78f5be59727e1828f55904be642bbbd7686c3f77eea92112625360d9ce"
  end

  depends_on macos: :tahoe

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/se-sshctl"
  end

  test do
    assert_equal "se-sshctl #{version}", shell_output("#{bin}/se-sshctl --version").strip

    report = JSON.parse(shell_output("#{bin}/se-sshctl doctor --json"))
    assert_equal version.to_s, report.fetch("seSSHCTL")
    assert_operator report.fetch("schemaVersion"), :>=, 1
  end
end
