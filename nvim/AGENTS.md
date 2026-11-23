# Neovim Configuration (dotfiles/nvim)

## Project Overview

Personal Neovim configuration using **lazy.nvim** as the plugin manager. Designed for C/C++ development with support for multiple languages.

## Architecture

```
nvim/
├── init.vim                 # Entry point, loads lua/init.lua
├── lua/
│   ├── init.lua             # Main init, loads all modules
│   ├── plugins.lua          # lazy.nvim plugin definitions
│   ├── setup.lua            # Vim options and settings
│   ├── keymap.lua           # Global keymaps
│   ├── theme.lua            # 加载默认主题 qtcreator（实现见仓库根的 colors/）
│   ├── base/                # Core utilities
│   │   ├── utils.lua        # Helper functions
│   │   ├── search.lua       # Telescope wrappers
│   │   └── jz.lua           # Custom buffer operations
│   ├── code/                # LSP & Treesitter
│   │   ├── lsp.lua          # Mason & lspconfig setup
│   │   ├── lspkind.lua      # LSP icons
│   │   ├── nvim-treesitter.lua
│   │   └── project.lua      # Project management
│   ├── completion/          # Completion engine
│   │   ├── install.lua      # blink.cmp plugin spec
│   │   └── setup/blink-cmp.lua  # Keymaps config
│   ├── debugger/            # DAP (Debug Adapter Protocol)
│   │   ├── install.lua      # nvim-dap setup
│   │   └── setup/dap.lua    # DAP utilities
│   ├── edit/                # Editing enhancements
│   │   └── setup/           # which-key, nvim-tree, autopairs, etc.
│   ├── lang/                # Language-specific config
│   │   ├── init.lua         # Loads all lang setups
│   │   ├── install.lua      # Language plugins
│   │   └── setup/           # Per-language configs
│   ├── menu/                # Telescope & fuzzy finding
│   │   └── setup/telescope.lua
│   ├── colors/              # 可选主题插件列表（install.lua）
│   └── tools/               # Additional tools (conform.nvim)
├── colors/qtcreator.lua     # 独立主题：静态高亮表，无插件依赖
├── after/lsp/               # LSP server configs (after/ so they override nvim-lspconfig)
│   ├── cc.lua
│   ├── lua_ls.lua
│   ├── pyright.lua
│   ├── gopls.lua
│   ├── rust_analyzer.lua
│   └── ...
├── snippets/                # VSCode-style snippets
├── after/ftplugin/          # Filetype-specific vim settings
└── ftdetect/                # Filetype detection
```

## Key Bindings

### Leader Keys
- **Leader**: `<space>`
- **LocalLeader**: `,`

### File Operations (`<leader>f`)
| Key | Action |
|-----|--------|
| `<leader>ff` | Project files (Telescope) |
| `<leader>fr` | Recent files |
| `<leader>ft` | File tree toggle |
| `<leader>fd` | File browser |
| `<leader>fb` | Bookmarks |

### Buffer Operations (`<leader>b`)
| Key | Action |
|-----|--------|
| `<leader>bb` | Buffer list |
| `<leader>bd` / `<leader>bk` | Close current buffer |
| `<leader>bn` / `<leader>bp` | Next/prev buffer |

### Search/Symbol (`<leader>s`)
| Key | Action |
|-----|--------|
| `<leader>ss` | Search current buffer |
| `<leader>si` | Document symbols |
| `<leader>sp` | Live grep in project |
| `<leader>sh` | Highlight word |

### Git (`<leader>g`)
| Key | Action |
|-----|--------|
| `<leader>gg` | Neogit status |
| `<leader>gb` | Git blame |
| `<leader>gl` | Git log |
| `<leader>gp` / `<leader>gP` | Push/Pull |

### Debug (DAP)
| Key | Action |
|-----|--------|
| `<F5>` | Continue/Start |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<leader>dv` | Toggle debug view |

### LSP Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gv` | Definition in vsplit |
| `gs` | Definition in split |
| `gf` | Code actions |

## Language Support

| Language | LSP | Formatter | Notes |
|----------|-----|-----------|-------|
| C/C++ | clangd | clang-format | clangd_extensions, DAP support |
| Lua | lua_ls | - | neodev |
| Python | pyright | ruff | ruff_format, ruff_organize_imports |
| Go | gopls | - | - |
| Rust | rust_analyzer | - | - |
| Markdown | marksman | - | render-markdown.nvim |
| CMake | neocmake | cmake_format | - |
| TOML | taplo | - | - |
| Shell | bashls | - | - |
| Proto | - | clang-format | - |

## Completion

Using **blink.cmp** with:
- LSP source
- Path source
- Snippets (friendly-snippets)
- Buffer source

Keymaps in completion:
- `<C-j>` / `<C-k>`: Navigate items
- `<CR>`: Accept selection
- `<C-u>` / `<C-d>`: Scroll docs
- `<C-space>`: Show snippets

## Project Root Detection

Uses `.projectile` or `.git` as root markers. The `utils.rootdir()` function finds project root.

## Special Features

### Clipboard
Uses OSC52 clipboard for terminal support (works over SSH).

### Treesitter
- Rainbow delimiters
- Textobjects
- Auto-install parsers

### AsyncRun
Integration with Telescope for task running (`<leader>rr`).

### Formatter
Uses `conform.nvim` for:
- cmake: cmake_format
- proto: clang-format
- python: ruff

## Important Files to Know

- **`lua/setup.lua`**: Vim options (tabstop, shiftwidth, encoding, etc.)
- **`lua/plugins.lua`**: Core plugin list (lazy.nvim setup)
- **`lua/keymap.lua`**: Global keymaps not in which-key
- **`after/lsp/*.lua`**: LSP server configurations (new-style `vim.lsp.config`). Must live under `after/`, not `lsp/`: nvim merges all `lsp/<name>.lua` on runtimepath with later entries winning, so configs in `~/.config/nvim/lsp/` (rtp-first) get overridden by nvim-lspconfig's own files.

## Debug Configuration

For C/C++ debugging:
1. Create `.vscode/launch.json` in project root
2. Use `<F5>` to start debug or create launch.json
3. Default uses gdb on Linux with program at `${workspaceFolder}/build/main`

## Customization Points

- Add new language: Create `lua/lang/setup/<lang>.lua` and require in `lua/lang/init.lua`
- Add LSP: Create `after/lsp/<server>.lua` using `vim.lsp.config()`, then enable it: mason-installed servers are auto-enabled by mason-lspconfig's `automatic_enable`, others need `vim.lsp.enable()` in `lua/plugins.lua`
- Add plugins: Edit `lua/plugins.lua` or create module in appropriate `*/install.lua`
