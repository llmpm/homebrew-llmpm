class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/89/77/f701d7bbbcac9d9c9c27b32a65926a67ca446f1218902706d50776f11306/llmpm-3.0.3.tar.gz"
  sha256 "220e0b36eb6ba88fdb7f4b7bedff3dc7bb60ff3e4d7d2e0f70f1e0f9f803a153"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/31/4d/4895e30efe4ba7c5cfe474a11a4667073564d87601bb14677ce3b4650d9d/llmpm-3.0.2.tar.gz"
      sha256 "7ed5de3c11bf5bdbf8264fb29e2e5ca0799ac98b991404f92058c8df8fbafedf"
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
