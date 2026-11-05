local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("colors.install"),
  require("completion.install"),
  require("menu.install"),
  require("lang.install"),
  require("edit.install"),
  require("debugger.install"),
  require("tools.install"),

  { "ton/vim-bufsurf",           event = "VeryLazy" },

  { "nvim-neotest/nvim-nio",     event = "VeryLazy" },

  { "akinsho/toggleterm.nvim",   event = "VeryLazy" },

  { "nvim-lualine/lualine.nvim", event = "VeryLazy" },

  { "nvim-lua/popup.nvim",       event = "VeryLazy" },

  { "nvim-lua/plenary.nvim",     event = "VeryLazy" },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate'
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- 超大文件（如 25 万行的 protobuf 生成代码）它是唯一在 FileType 时同步全树解析的插件，
      -- 打开要 80 秒以上；阈值与 autocmd.lua 的 big-file 一致
      vim.g.rainbow_delimiters = {
        condition = function(bufnr)
          return vim.api.nvim_buf_line_count(bufnr) <= 10000
        end,
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.g.no_plugin_maps = true
    end,
  },

  {
    "neovim/nvim-lspconfig",
    -- event = "VeryLazy",
    dependencies = { "saghen/blink.cmp" },
  },

  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      require("mason-lspconfig").setup({
        automatic_enable = { exclude = { "clangd" } },
      })

       vim.lsp.enable("clice")
    end,
  },

  { "vim-scripts/bufkill.vim",    event = "VeryLazy" },

  { "onsails/lspkind-nvim",       event = "VeryLazy" },

  { "paopaol/e-kaput.nvim",       event = "VeryLazy" },

  { "ahmedkhalf/project.nvim",    event = "VeryLazy" },

  { "kazhala/close-buffers.nvim", event = "VeryLazy" },

  { "tpope/vim-fugitive",         event = "VeryLazy" },

  { "sindrets/diffview.nvim",     event = "VeryLazy", dependencies = "nvim-lua/plenary.nvim" },

  { "AndrewRadev/linediff.vim",   event = "VeryLazy" },

  { "thinca/vim-qfreplace",       event = "VeryLazy" },

  { "akinsho/git-conflict.nvim",  event = "VeryLazy", version = "*",                         config = true },

  { "j-hui/fidget.nvim",          event = "VeryLazy", tag = "legacy",                        config = true },
})
