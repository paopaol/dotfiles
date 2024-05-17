local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- "gbprod/yanky.nvim",
  "ton/vim-bufsurf",
  { "nvim-neotest/nvim-nio" },
  "akinsho/toggleterm.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-treesitter/nvim-treesitter",             build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects", lazy = false },

  -- { "Pocco81/auto-save.nvim" },

  "neovim/nvim-lspconfig",
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },


  "vim-scripts/bufkill.vim",
  -- "karb94/neoscroll.nvim",
  -- "mhartington/formatter.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  -- "onsails/lspkind-nvim",
  "paopaol/e-kaput.nvim",


  { "ahmedkhalf/project.nvim", branch = "main",                    lazy = true },
  "kazhala/close-buffers.nvim",


  -- { "lilydjwg/fcitx.vim",       branch = "fcitx5" },
  require('colors.install'),
  require('completion.install'),
  require('menu.install'),
  require('lang.install'),
  require('edit.install'),

  -- "rainbowhxch/accelerated-jk.nvim",

  "tpope/vim-fugitive",
  { 'sindrets/diffview.nvim',    dependencies = 'nvim-lua/plenary.nvim', lazy = true },
  "thinca/vim-qfreplace",
  { 'akinsho/git-conflict.nvim', version = "*",                          config = true },


  { "j-hui/fidget.nvim",         tag = 'legacy' },
  -- 'theHamsta/nvim-semantic-tokens',
  "yorickpeterse/nvim-pqf",
})
-- end)
-- end)
