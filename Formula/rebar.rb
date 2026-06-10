class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/86/d1/ccccd14225ea28f37e5454340b439dd3feeb6b6cff2a48030112b7dbb90c/nava_rebar-0.3.0.tar.gz"
  sha256 "88a1076b4020a506caa14e299cda3d244ebe1534a98b97cdc4bfc363dfe54ff5"
  license "Apache-2.0"

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
