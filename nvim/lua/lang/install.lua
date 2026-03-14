return {
  { "paopaol/cpp-mode", ft = { "c", "cpp" } },

  { "Badhi/nvim-treesitter-cpp-tools", ft = { "c", "cpp" } },

  { "plasticboy/vim-markdown", ft = "markdown" },

  { "jakewvincent/mkdnflow.nvim", ft = "markdown", rocks = "luautf8" },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  { "mklabs/vim-json", ft = "json" },

  { "cespare/vim-toml", ft = "toml" },

  { "othree/html5.vim", ft = "html" },

  { "matveyt/vim-qmake", ft = "pro" },

  { "folke/lua-dev.nvim", ft = "lua", branch = "main" },

  { "rafamadriz/friendly-snippets", branch = "main" },

  { "p00f/clangd_extensions.nvim", ft = { "c", "cpp" } },
}
