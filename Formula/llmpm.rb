class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/31/4d/4895e30efe4ba7c5cfe474a11a4667073564d87601bb14677ce3b4650d9d/llmpm-3.0.2.tar.gz"
  sha256 "7ed5de3c11bf5bdbf8264fb29e2e5ca0799ac98b991404f92058c8df8fbafedf"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/96/a8/e5c19c5e5a06b3b36e49025c929262c452e270d8a072098c969c49f2ef78/llmpm-3.0.1.tar.gz"
      sha256 "79fc9dccdc0816231f114c6f789bb8cbb6ed0cf35acb15a6cf04b16f51b2c3b7"
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
