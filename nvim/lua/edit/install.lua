return {
  require('edit.asyncrun'),
  require('edit.which-key'),
  require('edit.nvim-tree'),
  require('edit.autopairs'),
  require('edit.dashboard-nvim'),
  "pseewald/vim-anyfold",
  {
    "akinsho/nvim-bufferline.lua",
    commit = "f6f00d9ac1a51483ac78418f9e63126119a70709",
  },
  {
    "rhysd/vim-textobj-anyblock",
    dependencies = {
      "kana/vim-textobj-user",
    }
  },
  {
    "kana/vim-textobj-line",
    dependencies = {
      "kana/vim-textobj-user",
    }
  },
  "paopaol/nvim-cursorline",
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
    lazy = true
  },
  { "folke/todo-comments.nvim", branch = "main" },
  "voldikss/vim-translator",
  {
    "MattesGroeger/vim-bookmarks",
    config = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end
  },
  { "p00f/nvim-ts-rainbow",     lazy = true },
  "AndrewRadev/sideways.vim",
  "paopaol/interestingwords.nvim",
  "godlygeek/tabular",
  { "fedepujol/move.nvim",    branch = "main" },
  "numToStr/Comment.nvim",
  { "mg979/vim-visual-multi", lazy = false },
  "mbbill/fencview",
  "chentoast/marks.nvim",
  "paopaol/messages.nvim",
  'jinh0/eyeliner.nvim',
  { 'windwp/nvim-ts-autotag', lazy = true },
  "tpope/vim-surround",
}
