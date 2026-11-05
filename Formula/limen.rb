# Written by scripts/render-formula.sh from a Limen release. Don't edit by hand.
class Limen < Formula
  desc "CLI for short-lived, audited access to SSH, databases and Kubernetes"
  homepage "https://github.com/limen-dev/limen"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/limen-dev/limen/releases/download/v0.1.0-rc.1/limen-v0.1.0-rc.1-aarch64-apple-darwin.tar.gz"
      sha256 "beeb26d84c75458db0d61f5dd97ed6fe1baf2a4fab582693f97fc4e3a272436c"
    end
    on_intel do
      url "https://github.com/limen-dev/limen/releases/download/v0.1.0-rc.1/limen-v0.1.0-rc.1-x86_64-apple-darwin.tar.gz"
      sha256 "d173b0ed562c24047bd9e6d5bf4dcc13d249873ddb70304e508458f73e53dd97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/limen-dev/limen/releases/download/v0.1.0-rc.1/limen-v0.1.0-rc.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35a7dec4904483f1652fff64af8abbad7ccf2c5e5fe05e6c7fb5ecf1dd007175"
    end
    on_intel do
      url "https://github.com/limen-dev/limen/releases/download/v0.1.0-rc.1/limen-v0.1.0-rc.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "05da25b23eed8dd2c1faf1b83e6bd1f4b9e0fe5c72a91e9cc6f7e1618eb95633"
    end
  end

  def install
    # The archive also holds the server binaries; the tap installs only the client tools.
    bin.install "limen", "limen-audit-verify"
    generate_completions_from_executable(bin/"limen", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/limen --version")
  end
end
