require "json"

class SeSshctl < Formula
  desc "Inspect Apple's CryptoTokenKit-backed SSH path"
  homepage "https://github.com/ajchemist/se-sshctl"
  url "https://github.com/ajchemist/se-sshctl/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "c0a371dc08cb6916d779bd452085fab3d8e0e4a816cbe3c038618f0ac4b81e2a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/ajchemist/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a32a93d97e62cff032805c803a85270908c8c28e657e910472ff90d613acefde"
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
