# My dotfiles

> Dotfiles for Windows and Linux

## 依赖

[dotter](https://github.com/SuperCuber/dotter)

## 应用

- Bat
- Delta
- Fish
- Git
- Helix
- Idea
- Lazygit
- Neovim
- Nushell
- Powershell
- Rio
- Starship
- Tmux
- Vim
- Wezterm
- Yazi

## 使用方式

### 安装dotter [可选]

> dotter分支下存放了Windows与Linux平台的dotter可执行文件

Windows:

```ps1
scoop install dotter
```

Cargo:

```sh
cargo install dotter
```

### 创建本地配置

在`.dotter`文件夹下，将`local.toml.example`重命名为`local.toml`

`local.toml`示例:

```toml
includes = [".dotter/include/windows.toml"]

packages = ["nvim"]

[files]

[variables]
```

### 执行dotter命令

> 注: Windows下需要**管理员权限**才能创建软链接

```sh
dotter -v # [-v]可选，显示详细信息

# 取消部署
dotter undeploy
```
