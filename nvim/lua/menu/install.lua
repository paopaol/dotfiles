return {
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = true, build = "make", branch = "main" },

  { "tom-anders/telescope-vim-bookmarks.nvim",  lazy = true, branch = "main" },

  {
    "GustavoKatel/telescope-asynctasks.nvim",
    lazy = true,
    branch = "main",
    dependencies = { "skywind3000/asynctasks.vim", "skywind3000/asyncrun.vim", },
  },

  { "nvim-telescope/telescope-ui-select.nvim", lazy = true, },

  {
    'paopaol/telescope-git-diffs.nvim',
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", },
  },

  { "nanotee/zoxide.vim",                      event = "VeryLazy", },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = { "Telescope" },
    branch = "master",
    config = require("menu.setup.telescope").config
  },
}
