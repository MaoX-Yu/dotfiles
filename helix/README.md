# My Helix

> Helix editor config

## LSP安装方式

### Python

[pyright](https://github.com/microsoft/pyright) - `npm install pyright -g`

[ruff](https://github.com/astral-sh/ruff-lsp) - `pip install ruff-lsp`

[black](https://github.com/psf/black) - `pip install black`

### Go

```shell
go install golang.org/x/tools/gopls@latest          # LSP
go install github.com/go-delve/delve/cmd/dlv@latest # Debugger
go install golang.org/x/tools/cmd/goimports@latest  # Formatter
```

### Rust

```shell
rustup component add rust-analyzer
```

[更多](https://github.com/helix-editor/helix/wiki/How-to-install-the-default-language-servers)