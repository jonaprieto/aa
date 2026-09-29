class Aa < Formula
  include Language::Python::Shebang

  desc "Search LibGen and download books and papers from the terminal"
  homepage "https://github.com/jonaprieto/aa"
  url "https://github.com/jonaprieto/aa/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "59edde691035389239bc4cedbb5f772a1e724f198f4d3b0b0549d69482962aaa"
  license "MIT"
  head "https://github.com/jonaprieto/aa.git", branch: "main"

  depends_on "python@3.13"

  def install
    rewrite_shebang detected_python_shebang, "aa"
    bin.install "aa"
  end

  test do
    assert_equal "ok", shell_output("#{bin}/aa selftest").strip
  end
end
