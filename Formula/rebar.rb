class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/12/03/ef6335129479897429e56f4b939fc96d7823f91b99fce66285d71581697b/nava_rebar-0.17.0.tar.gz"
  sha256 "8e9068206c8325aa2156ce59084616d8aa7a4099681afc32af28a7c03b545d68"
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
