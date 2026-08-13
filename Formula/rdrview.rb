class Rdrview < Formula
  desc "Command-line tool to extract the main content from a webpage"
  homepage "https://github.com/eafer/rdrview"
  url "https://github.com/eafer/rdrview/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "e83266cb2e3b16a42f3433101d1f312350ce1442561eaded67efb51c2e8e8aab"
  license "Apache-2.0"

  depends_on "curl"
  depends_on "libxml2"

  def install
    system "make", "PREFIX=#{prefix}"
    bin.install "rdrview"
    man1.install "rdrview.1"
  end

  test do
    html = testpath/"page.html"
    html.write "<html><body><article><h1>Title</h1>" \
               "<p>Some paragraph text long enough to be picked up.</p>" \
               "</article></body></html>"
    output = shell_output("#{bin}/rdrview --disable-sandbox -H #{html}")
    assert_match "Some paragraph text", output
  end
end
