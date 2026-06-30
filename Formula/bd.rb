class Bd < Formula
  desc "AI-supervised issue tracker for coding workflows (flatfile fork)"
  homepage "https://github.com/MarkAtwood/beads"
  license "MIT"
  head "https://github.com/MarkAtwood/beads.git", branch: "pr/flatfile-backend"
  # b7470a56 fix(flatfile): tolerate type-coerced JSON from raw SQL exports
  revision 1

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
      -X main.Build=#{Utils.git_short_head}
      -X main.Commit=#{Utils.git_head}
      -X main.Branch=pr/flatfile-backend
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/bd"
  end

  test do
    assert_match "bd version", shell_output("#{bin}/bd --version")
  end
end
