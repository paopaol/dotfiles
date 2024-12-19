local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require('colors.install'),
  require('completion.install'),
  require('menu.install'),
  require('lang.install'),
  require('edit.install'),
  require('debugger.install'),
  require('tools.install'),

  "ton/vim-bufsurf",
  { "nvim-neotest/nvim-nio" },
  "akinsho/toggleterm.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-treesitter/nvim-treesitter",             build = ":TSUpdate", event = "VeryLazy" },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },


  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },


  "vim-scripts/bufkill.vim",
  "jose-elias-alvarez/null-ls.nvim",
  "onsails/lspkind-nvim",
  "paopaol/e-kaput.nvim",


  { "ahmedkhalf/project.nvim", branch = "main",                    lazy = true },
  "kazhala/close-buffers.nvim",


  -- { "lilydjwg/fcitx.vim",       branch = "fcitx5" },

  "tpope/vim-fugitive",
  { 'sindrets/diffview.nvim',    dependencies = 'nvim-lua/plenary.nvim', lazy = true },
  "thinca/vim-qfreplace",
  { 'akinsho/git-conflict.nvim', version = "*",                          config = true },
  { "j-hui/fidget.nvim",         tag = 'legacy',                         config = true },
})
-- end)
-- end)
