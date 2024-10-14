# My Helix

> Helix editor config

## LSP安装方式

### Python

[basedpyright](https://github.com/detachhead/basedpyright) - `pip install basedpyright`

[ruff](https://github.com/astral-sh/ruff) - `pip install ruff`

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

[更多](https://github.com/helix-editor/helix/wiki/Language-Server-Configurations)
