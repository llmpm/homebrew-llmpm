class Llmpm < Formula
  include Language::Python::Virtualenv

  desc "Command-line package manager for large language models"
  homepage "https://llmpm.co"
  url "https://files.pythonhosted.org/packages/fc/c2/8daa6fc6327c4b7c5f0eae8e40c9851ff764a76904d8429758210150f5df/llmpm-2.2.1.tar.gz"
  sha256 "d5f2ae2247db79a490a83c480a83f8b642ca1099d937578c674a4cd389b12ae9"
  license "MIT"

  # Only the lightweight CLI deps are installed here.
  # Heavy ML backends (torch, transformers, diffusers, …) are bootstrapped
  # automatically into ~/.llmpm/venv on first run — keeping Homebrew lean.
  depends_on "python@3.12"

    resource "llmpm" do
      url "https://files.pythonhosted.org/packages/fc/c2/8daa6fc6327c4b7c5f0eae8e40c9851ff764a76904d8429758210150f5df/llmpm-2.2.1.tar.gz"
      sha256 "d5f2ae2247db79a490a83c480a83f8b642ca1099d937578c674a4cd389b12ae9"
    end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llmpm --version")
    system bin/"llmpm", "--help"
  end
end
