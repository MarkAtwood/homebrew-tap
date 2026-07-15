class Bd < Formula
  desc "AI-supervised issue tracker for coding workflows (flatfile fork)"
  homepage "https://github.com/MarkAtwood/beads"
  url "https://github.com/MarkAtwood/beads/archive/refs/tags/v1.1.0-flatfile.2.tar.gz"
  # Explicit version: brew parses the tag's trailing ".2" as the whole version
  # otherwise (Cellar/bd/2, bd --version "2").
  version "1.1.0-flatfile.2"
  sha256 "2fc7996c1be56e03f95ec66b3104dc264569d40402547c5facd6d3fce5c0c62f"
  license "MIT"
  # Stable builds from tagged releases on the fork; head tracks the `flatfile`
  # release branch, which is fast-forwarded only after the full test gauntlet
  # passes — never the raw PR branch, which force-pushes mid-review.
  head "https://github.com/MarkAtwood/beads.git", branch: "flatfile"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
      -X main.Build=brew
    ]
    if build.head?
      ldflags += %W[
        -X main.Commit=#{Utils.git_head}
        -X main.Branch=flatfile
      ]
    end
    system "go", "build", *std_go_args(ldflags:), "./cmd/bd"
  end

  test do
    assert_match "bd version", shell_output("#{bin}/bd --version")
  end
end
