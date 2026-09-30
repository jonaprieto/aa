class Folio < Formula
  include Language::Python::Shebang

  desc "Find and download books and papers from the terminal or an AI agent"
  homepage "https://github.com/jonaprieto/folio"
  url "https://github.com/jonaprieto/folio/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "269fd03aef46f9b61afb7d5e9f825785cde9dff759280b0109871d131b0479ff"
  license "MIT"
  head "https://github.com/jonaprieto/folio.git", branch: "main"

  depends_on "python@3.13"

  def install
    rewrite_shebang detected_python_shebang, "folio"
    bin.install "folio"
  end

  test do
    assert_equal "ok", shell_output("#{bin}/folio selftest").strip
  end
end
