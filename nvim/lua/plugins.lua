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
  { "folke/which-key.nvim",         branch = "main" },
  { "rafamadriz/friendly-snippets", branch = "main" },
  "L3MON4D3/LuaSnip",
  "mbbill/fencview",
  { "nvim-telescope/telescope.nvim",            branch = "master" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make",   branch = "main" },
  { "crispgm/telescope-heading.nvim",           branch = "main" },
  { "tom-anders/telescope-vim-bookmarks.nvim",  branch = "main" },
  { "GustavoKatel/telescope-asynctasks.nvim",   branch = "main" },
  "benfowler/telescope-luasnip.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  { "nvim-telescope/telescope-ui-select.nvim" },
  "p00f/clangd_extensions.nvim",
  { "paopaol/cpp-mode",                       ft = { "c", "cpp" } },
  { "paopaol/vim-gtest",                      ft = { "c", "cpp" } },
  { "Badhi/nvim-treesitter-cpp-tools",        ft = { "c", "cpp" } },
  "chentoast/marks.nvim",
  "paopaol/messages.nvim",
  'jinh0/eyeliner.nvim',
  "gbprod/yanky.nvim",
  'windwp/nvim-ts-autotag',
  "ton/vim-bufsurf",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "akinsho/toggleterm.nvim",
  "chiel92/vim-autoformat",
  "nvim-lualine/lualine.nvim",
  "akinsho/nvim-bufferline.lua",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- { "Pocco81/auto-save.nvim" },

  "neovim/nvim-lspconfig",
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },


  "windwp/nvim-autopairs",
  "MattesGroeger/vim-bookmarks",
  "vim-scripts/bufkill.vim",
  "karb94/neoscroll.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- "mhartington/formatter.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  -- "onsails/lspkind-nvim",
  "paopaol/e-kaput.nvim",
  "voldikss/vim-translator",
  "p00f/nvim-ts-rainbow",
  "goolord/alpha-nvim",


  { "ahmedkhalf/project.nvim", branch = "main" },
  "kazhala/close-buffers.nvim",
  "romgrk/nvim-treesitter-context",
  { "folke/todo-comments.nvim", branch = "main" },


  -- { "lilydjwg/fcitx.vim",       branch = "fcitx5" },
  "ofirgall/ofirkai.nvim",
  "EdenEast/nightfox.nvim",
  'folke/tokyonight.nvim',
  'Mofiqul/dracula.nvim',

  "rainbowhxch/accelerated-jk.nvim",

  { "plasticboy/vim-markdown",  ft = "markdown" },
  {
    'jakewvincent/mkdnflow.nvim',
    ft = "markdown",
    rocks = 'luautf8',
  },
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install", ft = "markdown" },
  "mg979/vim-visual-multi",
  "pseewald/vim-anyfold",
  { "mattn/emmet-vim",              ft = "html5" },
  "skywind3000/asynctasks.vim",
  "skywind3000/asyncrun.vim",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  { 'sindrets/diffview.nvim',    dependencies = 'nvim-lua/plenary.nvim' },
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
  "thinca/vim-qfreplace",
  {
    'paopaol/telescope-git-diffs.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
    },
  },
  { 'akinsho/git-conflict.nvim', version = "*",                         config = true },
  { "othree/html5.vim",          ft = "html" },
  "mklabs/vim-json",
  { "cespare/vim-toml",  ft = "toml" },
  "paopaol/nvim-cursorline",
  "godlygeek/tabular",
  "AndrewRadev/sideways.vim",
  { "matveyt/vim-qmake", ft = "pro" },
  "paopaol/interestingwords.nvim",

  --cmp
  { "hrsh7th/cmp-nvim-lsp", branch = "main" },
  { "hrsh7th/cmp-path",     branch = "main" },
  { "hrsh7th/nvim-cmp",     branch = "main" },
  { "hrsh7th/cmp-buffer",   branch = "main" },
  "dcampos/cmp-emmet-vim",

  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-cmdline",
  "paopaol/cmp-doxygen",
  "paopaol/telescope-command.nvim",

  { "fedepujol/move.nvim",       branch = "main" },
  "numToStr/Comment.nvim",
  { "folke/lua-dev.nvim",        branch = "main", ft = "lua" },
  { "j-hui/fidget.nvim",         tag = 'legacy' },
  { "Civitasv/cmake-tools.nvim", ft = "cmake" },
  "jbyuki/venn.nvim",
  -- 'theHamsta/nvim-semantic-tokens',
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        's1n7ax/nvim-window-picker',
      }
    },
  }
})
-- end)
