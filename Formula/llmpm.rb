class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/c5/3e/1c6af050c186240780117a33a3c462fe668e475161e0bbbeee1de0e57b2a/llmpm-3.1.3.tar.gz"
  sha256 "871b918945b6440c582ce0e4c1772cd061289dc1eabccdb09fc20a76b7e28186"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/c5/3e/1c6af050c186240780117a33a3c462fe668e475161e0bbbeee1de0e57b2a/llmpm-3.1.3.tar.gz"
      sha256 "871b918945b6440c582ce0e4c1772cd061289dc1eabccdb09fc20a76b7e28186"
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
