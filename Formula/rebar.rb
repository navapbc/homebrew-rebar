class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/cb/74/511bc7ed31fd8ffdd6bcea43f80f1157f6e5c75d2e01e9bd29cdc320911d/nava_rebar-0.5.1.tar.gz"
  sha256 "08467306e89df323fd3f8e63d2ef581e6eb9d9edf1f28bd1042892c03c570b2d"
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
