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

  { "ton/vim-bufsurf", event = "VeryLazy" },

  { "nvim-neotest/nvim-nio", event = "VeryLazy" },

  { "akinsho/toggleterm.nvim", event = "VeryLazy" },

  { "nvim-lualine/lualine.nvim", event = "VeryLazy" },

  { "nvim-lua/popup.nvim", event = "VeryLazy" },

  { "nvim-lua/plenary.nvim", event = "VeryLazy" },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
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
      require("mason-lspconfig").setup({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("blink.cmp").get_lsp_capabilities(),
          })
        end,
      })
    end,
  },

  { "vim-scripts/bufkill.vim", event = "VeryLazy" },

  { "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy" },

  { "onsails/lspkind-nvim", event = "VeryLazy" },

  { "paopaol/e-kaput.nvim", event = "VeryLazy" },

  { "ahmedkhalf/project.nvim", event = "VeryLazy" },

  { "kazhala/close-buffers.nvim", event = "VeryLazy" },

  { "tpope/vim-fugitive", event = "VeryLazy" },

  { "sindrets/diffview.nvim", event = "VeryLazy", dependencies = "nvim-lua/plenary.nvim" },

  { "thinca/vim-qfreplace", event = "VeryLazy" },

  { "akinsho/git-conflict.nvim", event = "VeryLazy", version = "*", config = true },

  { "j-hui/fidget.nvim", event = "VeryLazy", tag = "legacy", config = true },
})
