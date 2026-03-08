# Dotfiles 项目说明

这是一个个人开发环境的点文件(dotfiles)管理仓库，包含了各种开发工具的配置文件。

## 项目概述

这个仓库用于管理和同步多个开发工具的配置文件，确保在不同环境中保持一致的开发体验。主要涵盖以下工具和框架：

### 核心配置

- **Emacs/Doom Emacs**: 基于 Doom Emacs 框架的 Emacs 配置，使用 Evil 模式和众多现代插件
- **Neovim**: 基于 Lua 的 Neovim 配置，使用 lazy.nvim 插件管理器
- **Zsh**: 使用 oh-my-zsh 框架的 Shell 配置
- **Tmux**: 基于 gpakosz/tmux 配置的终端复用器配置

### 辅助工具配置

- **GDB**: 包含 Qt5 和 STL 的 pretty printers，用于调试 C++ 代码
- **Xkeysnail**: 键盘映射配置，自定义快捷键
- **Wireshark**: Lua API 配置
- **代码格式化**: `.clang-format`、`.stylua.toml` 等格式化配置

## 目录结构

```
dotfiles/
├── .doom.d/              # Doom Emacs 配置目录
│   ├── init.el           # Doom Emacs 初始化文件
│   ├── config.el         # Doom Emacs 主配置
│   ├── packages.el       # Doom Emacs 包管理配置
│   └── snippets/         # 代码片段
├── .gdb/                 # GDB 调试器配置
│   ├── qt5prettyprinters/    # Qt5 pretty printers
│   └── stlprettyprinter/     # STL pretty printers
├── nvim/                 # Neovim 配置目录
│   ├── lua/              # Lua 配置脚本
│   │   ├── init.lua      # 主入口文件
│   │   ├── plugins.lua   # 插件配置
│   │   ├── setup.lua     # 基础设置
│   │   ├── keymap.lua    # 键位映射
│   │   ├── theme.lua     # 主题配置
│   │   ├── code/         # 代码相关配置（LSP、treesitter等）
│   │   ├── completion/   # 自动补全配置
│   │   ├── edit/         # 编辑增强配置
│   │   ├── menu/         # 菜单和导航配置
│   │   ├── lang/         # 语言特定配置
│   │   └── tools/        # 工具配置
│   ├── init.vim          # Vim 入口文件（加载 Lua）
│   ├── lsp/              # LSP 服务器配置
│   └── after/            # 自动加载配置
├── wireshark/            # Wireshark 相关配置
├── .bashrc               # Bash Shell 配置
├── .zshrc                # Zsh Shell 配置（oh-my-zsh）
├── .tmux.conf            # Tmux 主配置
├── .tmux.conf.local      # Tmux 本地配置
├── .gdbinit              # GDB 初始化配置
├── .Xmodmap              # X11 键盘映射
├── .editorConfig         # 编辑器通用配置
├── .clang-format         # C/C++ 代码格式化配置
├── .stylua.toml          # Lua 代码格式化配置
├── c.vim                 # C 语言 Vim 配置
├── cpp.vim               # C++ 语言 Vim 配置
├── xkeysnail.py          # Xkeysnail 键盘映射
├── xkeysnail.service     # Xkeysnail systemd 服务
├── init.el               # Emacs 配置（非 Doom）
├── config.el             # Emacs 配置（非 Doom）
└── packages.el           # Emacs 包配置（非 Doom）
```

## 主要配置特点

### Emacs 配置

- 使用 Doom Emacs 框架，配置位于 `.doom.d/` 目录
- 同时保留了传统 Emacs 配置（`init.el`、`config.el`、`packages.el`）
- 配置了 Evil 模式（Vim 模拟）
- 集成了 LSP 支持（Eglot）
- 使用 Corfu 进行自动补全
- 配置了 Treemacs 文件浏览器
- 使用 Consult 和 Vertico 进行搜索和导航

### Neovim 配置

- 完全基于 Lua 配置
- 使用 lazy.nvim 作为插件管理器
- 集成了 LSP 支持（mason.nvim + nvim-lspconfig）
- 使用 blink.cmp 进行自动补全
- 配置了 Telescope 用于模糊搜索
- 支持 Treesitter 语法高亮
- 集成了 Git 相关工具（fugitive、diffview）
- 使用 OSC 52 进行剪贴板操作（支持远程环境）

### Zsh 配置

- 基于 oh-my-zsh 框架
- 主题：fino
- 启用的插件：
  - zsh-autosuggestions（自动建议）
  - zsh-syntax-highlighting（语法高亮）
  - git（Git 支持）
  - zoxide（智能目录跳转）
- 集成了 NVM（Node 版本管理）

### Tmux 配置

- 基于 gpakosz/tmux 配置
- 配置了丰富的快捷键
- 支持鼠标操作
- 支持剪贴板操作（X11、Wayland、macOS、Windows）
- 配置了电池状态显示
- 支持 SSH 会话自动检测

### GDB 配置

- Qt5 pretty printers：支持 Qt 类型的美观打印
- STL pretty printers：支持 C++ STL 类型的美观打印

### Xkeysnail 配置

- 自定义键盘映射
- Super-j 映射为 down
- Super-k 映射为 up

## 安装和使用

### 基本安装步骤

1. 克隆仓库到主目录：
```bash
git clone https://github.com/paopaol/dotfiles.git ~/dotfiles
```

2. 创建符号链接到主目录：
```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local
ln -s ~/dotfiles/.gdbinit ~/.gdbinit
ln -s ~/dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/dotfiles/.editorConfig ~/.editorConfig
ln -s ~/dotfiles/.clang-format ~/.clang-format
ln -s ~/dotfiles/.stylua.toml ~/.stylua.toml
ln -s ~/dotfiles/c.vim ~/.vim/after/ftplugin/c.vim
ln -s ~/dotfiles/cpp.vim ~/.vim/after/ftplugin/cpp.vim
```

3. Neovim 配置：
```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
```

4. Doom Emacs 配置：
```bash
ln -s ~/dotfiles/.doom.d ~/.doom.d
```

5. 安装依赖：
   - Oh-my-zsh: 按照 https://ohmyz.sh/ 安装
   - Doom Emacs: 按照 https://github.com/doomemacs/doomemacs 安装
   - Neovim 插件: 启动 Neovim，lazy.nvim 会自动安装插件

### 初始化 Doom Emacs

```bash
doom sync
```

### 初始化 Neovim

```bash
nvim  # 首次启动会自动安装插件
```

### 启动 Xkeysnail

```bash
sudo systemctl start xkeysnail
# 或者
sudo xkeysnail xkeysnail.py
```

## 开发约定

### 配置文件组织

- **Emacs/Doom**: 配置按功能模块化组织，使用 `use-package` 管理包
- **Neovim**: 配置完全模块化，每个功能都有独立的 Lua 文件
- **Shell**: 使用 oh-my-zsh 插件系统，自定义配置放在 `.zshrc` 中
- **Tmux**: 主配置使用 gpakosz/tmux，自定义配置放在 `.tmux.conf.local`

### 代码风格

- C/C++: 使用 `.clang-format` 配置
- Lua: 使用 `.stylua.toml` 配置
- 遵循各语言的通用最佳实践

### Git 使用

- 当前分支: master
- 远程仓库: https://github.com/paopaol/dotfiles
- 提交信息风格: 简洁，使用 "update" 作为提交消息

## 支持的语言和工具

### 编程语言

- **C/C++**: LSP (clangd)、代码片段、格式化、调试
- **Python**: LSP (pyright)、代码片段
- **Go**: LSP (gopls)
- **Rust**: LSP (rust_analyzer)
- **Lua**: LSP (lua_ls)
- **JavaScript/TypeScript**: LSP 支持
- **Protocol Buffers**: 语法高亮、LSP 支持
- **Shell**: LSP (bashls)
- **GitLab CI**: LSP 支持
- **CMake**: LSP (neocmake)
- **TOML**: LSP (taplo)
- **Markdown**: 预览、格式化

### 开发工具

- **Git**: 集成到编辑器中（fugitive、diffview、git-conflict）
- **调试**: Neovim DAP、GDB pretty printers
- **构建**: AsyncRun、Terminal 支持
- **测试**: 集成测试支持

## 注意事项

1. **Python 环境**: Neovim 配置中指定了 Python3 路径为 `/home/jz/.env/python3/bin/python3`，需要确保该路径存在
2. **剪贴板**: Neovim 使用 OSC 52 协议进行剪贴板操作，支持远程环境
3. **字体**: Neovim 配置使用 DejaVu Sans Mono 字体
4. **主题**:
   - Neovim: 使用 nightfox 主题
   - Emacs: 使用 doom-dracula 主题
5. **Xkeysnail**: 需要 root 权限运行，可以使用 systemd 服务

## 待办事项

- [ ] 完善各语言的 LSP 配置文档
- [ ] 添加更多代码片段
- [ ] 优化 Neovim 启动性能
- [ ] 添加更多调试器配置
- [ ] 完善 Wireshark 配置说明