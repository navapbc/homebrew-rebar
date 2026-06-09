# homebrew-rebar

Homebrew tap for [rebar](https://github.com/navapbc/rebar) — an event-sourced
ticket system with a Jira reconciler (PyPI distribution: `nava-rebar`).

```sh
brew install navapbc/rebar/rebar
# or:  brew tap navapbc/rebar && brew install rebar
```

Installs the `rebar` CLI (and the `rebar` Python library inside the formula's
virtualenv). The optional MCP server `rebar-mcp` needs the `mcp` extra — install
it with `pipx install 'nava-rebar[mcp]'` or run it via `uvx --from nava-rebar[mcp] rebar-mcp`.
