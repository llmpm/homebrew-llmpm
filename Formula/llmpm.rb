class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/9d/0e/7d6d1520ec7ab0d59c988443e719e4888c3275b5a85a172a6ea15bd76f2c/llmpm-2.2.3.tar.gz"
  sha256 "745d5d57b681c118f15044a8270a18311b6241003a56a87bc531e849befb1fd3"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

  resource "llmpm" do
      url "https://files.pythonhosted.org/packages/9d/0e/7d6d1520ec7ab0d59c988443e719e4888c3275b5a85a172a6ea15bd76f2c/llmpm-2.2.3.tar.gz"
      sha256 "745d5d57b681c118f15044a8270a18311b6241003a56a87bc531e849befb1fd3"
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
