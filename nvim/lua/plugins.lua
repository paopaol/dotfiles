require('impatient')
-- require 'impatient'.enable_profile()
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use({ "folke/which-key.nvim", branch = "main" })
  use({ "rafamadriz/friendly-snippets", branch = "main" })
  use("L3MON4D3/LuaSnip")
  use("mbbill/fencview")
  use({ "nvim-telescope/telescope.nvim", branch = "master" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", branch = "main" })
  use({ "crispgm/telescope-heading.nvim", branch = "main" })
  use({ "tom-anders/telescope-vim-bookmarks.nvim", branch = "main" })
  use({ "GustavoKatel/telescope-asynctasks.nvim", branch = "main" })
  use("benfowler/telescope-luasnip.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use("paopaol/cpp-mode")
  use("paopaol/vim-gtest")
  use({ "Badhi/nvim-treesitter-cpp-tools" })
  use("chentoast/marks.nvim")
  use({
    "AckslD/messages.nvim",
    config = 'require("messages").setup()',
  })

  use('windwp/nvim-ts-autotag')
  use({ "rhysd/clever-f.vim" })
  use("ton/vim-bufsurf")
  use("mfussenegger/nvim-dap")
  use("akinsho/toggleterm.nvim")
  use("chiel92/vim-autoformat")
  use("kyazdani42/nvim-web-devicons")
  use("nvim-lualine/lualine.nvim")
  use("akinsho/nvim-bufferline.lua")
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  use("neovim/nvim-lspconfig")
  use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })


  use("windwp/nvim-autopairs")
  use("MattesGroeger/vim-bookmarks")
  use("vim-scripts/bufkill.vim")
  use("voldikss/vim-floaterm")
  use("karb94/neoscroll.nvim")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("mhartington/formatter.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  use("onsails/lspkind-nvim")
  use("paopaol/e-kaput.nvim")
  use("voldikss/vim-translator")
  -- use ('uga-rosa/translate.nvim')
  use("p00f/nvim-ts-rainbow")
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  })

  use({ "ahmedkhalf/project.nvim", branch = "main" })
  use("TimUntersberger/neogit")
  use("kazhala/close-buffers.nvim")
  use("romgrk/nvim-treesitter-context")
  use({ "folke/todo-comments.nvim", branch = "main" })
  use("907th/vim-auto-save")


  use({ "lilydjwg/fcitx.vim", branch = "fcitx5" })
  use("projekt0n/github-nvim-theme")
  use "EdenEast/nightfox.nvim"
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'

  use("rainbowhxch/accelerated-jk.nvim")
  use("vim-scripts/DoxygenToolkit.vim")

  use("plasticboy/vim-markdown")
  use({ 'jakewvincent/mkdnflow.nvim',
    rocks = 'luautf8',
  })
  use("terryma/vim-expand-region")
  use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
  use("easymotion/vim-easymotion")
  use("haya14busa/incsearch.vim")
  use("haya14busa/incsearch-easymotion.vim")
  use("haya14busa/incsearch-fuzzy.vim")
  use("mg979/vim-visual-multi")
  use("pseewald/vim-anyfold")
  use("mattn/emmet-vim")
  use("skywind3000/asynctasks.vim")
  use("skywind3000/asyncrun.vim")
  use("tpope/vim-surround")
  use("tpope/vim-fugitive")
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use("kana/vim-textobj-user")
  use("sgur/vim-textobj-parameter")
  use("rhysd/vim-textobj-anyblock")
  use("thinca/vim-qfreplace")
  use("paopaol/telescope-git-diffs.nvim")
  -- use("markonm/traces.vim")
  use("othree/html5.vim")
  use("mklabs/vim-json")
  use("kana/vim-textobj-line")
  use("cespare/vim-toml")
  use("yamatsum/nvim-cursorline")
  use("puremourning/vimspector")
  use("godlygeek/tabular")
  use("AndrewRadev/sideways.vim")
  use("rust-lang/rust.vim")
  use("matveyt/vim-qmake")
  use("paopaol/interestingwords.nvim")

  --cmp
  use({ "hrsh7th/cmp-nvim-lsp", branch = "main" })
  use({ "hrsh7th/cmp-path", branch = "main" })
  use({ "hrsh7th/nvim-cmp", branch = "main" })
  use({ "hrsh7th/cmp-buffer", branch = "main" })
  use("dcampos/cmp-emmet-vim")

  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/cmp-cmdline")
  use("paopaol/cmp-doxygen")

  use({ "fedepujol/move.nvim", branch = "main" })
  use("numToStr/Comment.nvim")
  use({ "folke/lua-dev.nvim", branch = "main" })
  use({ "j-hui/fidget.nvim", branch = "main" })
  use("Civitasv/cmake-tools.nvim")
  use 'lewis6991/impatient.nvim'
  use 'ethanholz/nvim-lastplace'
  use({ "nvim-neorg/neorg", branch = "main" })
  use "jbyuki/venn.nvim"
  use 'theHamsta/nvim-semantic-tokens'
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        's1n7ax/nvim-window-picker',
        tag = "v1.*",
      }
    },
  }
end)
