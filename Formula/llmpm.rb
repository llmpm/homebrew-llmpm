class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/c8/30/0cdb242ad8e3e19b7b44de69d21b13c740a1f9a620cbf84e2a531af01284/llmpm-3.1.0.tar.gz"
  sha256 "269cf16429aa3148599e9f444377872386040e6e5a6c4dcffabb87a34b9baf57"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/c8/30/0cdb242ad8e3e19b7b44de69d21b13c740a1f9a620cbf84e2a531af01284/llmpm-3.1.0.tar.gz"
      sha256 "269cf16429aa3148599e9f444377872386040e6e5a6c4dcffabb87a34b9baf57"
    end

  def install
    virtualenv_install_with_resources
    # Explicit symlink ensures the binary is reachable even if the automatic
    # pip_install_and_link detection misses it (e.g. on older Homebrew versions).
    bin.install_symlink libexec/"bin/llmpm" unless (bin/"llmpm").exist?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llmpm --version")
    system bin/"llmpm", "--help"
  end
end
