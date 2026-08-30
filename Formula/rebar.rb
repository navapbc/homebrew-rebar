class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/3a/63/bda1369ceb37fc9173fa42d9aefb98fd74a10627a6c7ae96f9229532e0a4/nava_rebar-0.13.1.tar.gz"
  sha256 "1d7726a6f2e8f408672b120426b9158595e683d449682934c4afe1c86c9cf473"
  license "Apache-2.0"

  depends_on "git"        # the ticket store is a git orphan branch + worktree
  depends_on "python@3.12"
  depends_on "util-linux" # provides flock for the write-lock (engine has a mkdir fallback)

  # The base package has zero pip dependencies, so the virtualenv needs no
  # resource blocks. (The optional MCP server `rebar-mcp` needs the `mcp` extra;
  # for that, `pipx install 'nava-rebar[mcp]'` or `uvx --from nava-rebar[mcp] rebar-mcp`.)
  def install
    virtualenv_install_with_resources
  end

  test do
    # `rebar` with no subcommand prints usage and exits non-zero.
    assert_match "Subcommands", shell_output("#{bin}/rebar 2>&1", 1)
  end
end
