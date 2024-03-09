class Jbang < Formula
  desc "Tool to create, edit and run self-contained source-only Java programs"
  homepage "https://jbang.dev/"
  url "https://github.com/jbangdev/jbang/releases/download/v0.115.0/jbang-0.115.0.zip"
  sha256 "51cbeee30e0c9d2ec50085777f4adc93eed77f2dfde0be37075926718b9bc0e5"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "72cf7965a80ebf39d6303bff8dfbeb768e775983016902dafec179356388e114"
  end

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    inreplace "#{libexec}/bin/jbang", /^abs_jbang_dir=.*/, "abs_jbang_dir=#{libexec}/bin"
    bin.install_symlink libexec/"bin/jbang"
  end

  test do
    system "#{bin}/jbang", "init", "--template=cli", testpath/"hello.java"
    assert_match "hello made with jbang", (testpath/"hello.java").read
    assert_match version.to_s, shell_output("#{bin}/jbang --version 2>&1")
  end
end
