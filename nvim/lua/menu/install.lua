return {
  { "nvim-telescope/telescope-fzf-native.nvim", event = "VeryLazy", build = "make", branch = "main" },

  { "tom-anders/telescope-vim-bookmarks.nvim",  event = "VeryLazy", branch = "main" },

  {
    "GustavoKatel/telescope-asynctasks.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = { "skywind3000/asynctasks.vim", "skywind3000/asyncrun.vim", },
  },

  { "nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy", },

  {
    'paopaol/telescope-git-diffs.nvim',
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", },
    config = function()
      require('telescope').setup {
        extensions = {
          git_diffs = {
            enable_preview_diff = false
          }
        }
      }
    end
  },

  { "nanotee/zoxide.vim",                      event = "VeryLazy", },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "master",
    config = require("menu.setup.telescope").config
  },
}
