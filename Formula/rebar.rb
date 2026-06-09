class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/5c/54/b16bb897a5fcc2a7e822c7a9cf2080dede4f541b409459d579f44fee4848/nava_rebar-0.1.0.tar.gz"
  sha256 "cbcabee090b877996b17c46d22876e768a3413b3324e100dcf8882041c9147ff"

  depends_on "git"        # the ticket store is a git orphan branch + worktree
  depends_on "jq"         # JSON in the bash engine
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
