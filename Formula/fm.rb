class Fm < Formula
  desc "Command-line interface for Fastmail"
  homepage "https://github.com/MarkAtwood/fastmail-cli"
  url "https://github.com/MarkAtwood/fastmail-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5dd124fe259cb34b49e8bcbc2ec479d7d00281069e3537a3651339b3c4191eeb"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/fm"
  end

  test do
    assert_match "fm version", shell_output("#{bin}/fm version")
  end
end
