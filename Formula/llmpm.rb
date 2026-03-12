class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/a6/3d/35cbaa3d5a018df0694981dc3ae61ff5cccd2cac71f3d9d9d8e81258842e/llmpm-3.1.4.tar.gz"
  sha256 "51018341a5a4a2a3fb9af6599bdc179a956258127efbf4104135a06d5cb08618"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/a6/3d/35cbaa3d5a018df0694981dc3ae61ff5cccd2cac71f3d9d9d8e81258842e/llmpm-3.1.4.tar.gz"
      sha256 "51018341a5a4a2a3fb9af6599bdc179a956258127efbf4104135a06d5cb08618"
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
