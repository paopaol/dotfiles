return {
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
  {
    "paopaol/nvim-cursorline",
    config = function()
      require('nvim-cursorline').setup {
        cursorline = {
          enable = false,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  },
  "paopaol/interestingwords.nvim",
  "tpope/vim-surround",
}
