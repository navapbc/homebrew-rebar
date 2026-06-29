class Rebar < Formula
  include Language::Python::Virtualenv

  desc "Event-sourced ticket system with a Jira reconciler (CLI, library, MCP)"
  homepage "https://github.com/navapbc/rebar"
  url "https://files.pythonhosted.org/packages/55/41/0c0b083fdf1c10179bf4b757cbbe93448e38b26ad58ce23d422d01cd68b8/nava_rebar-0.6.0.tar.gz"
  sha256 "cb8166053e4b13d9d5214f456f839108e6db858c4f2815a5a2da1e9700e3410f"
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
