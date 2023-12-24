# My dotfiles

> Dotfiles for Windows and Linux

## 依赖

[dotter](https://github.com/SuperCuber/dotter)

## 使用方式

### 安装dotter

Windows:

```powershell
scoop install dotter
```

Cargo:

```shell
cargo install dotter
```

### 创建本地配置

在`.dotter`文件夹下创建`local.toml`文件，内容如下:

```toml
includes = [".dotter/include/windows.toml"]

packages = ["nvim"]

[files]

[variables]

```

### 执行dotter命令

> 注: Windows下需要**管理员权限**才能创建软链接

```shell
dotter -v # [-v]可选，显示详细信息

# 取消部署
dotter undeploy
```

