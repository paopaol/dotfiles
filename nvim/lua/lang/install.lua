return {
  { "paopaol/cpp-mode", ft = { "c", "cpp" } },

  { "Badhi/nvim-treesitter-cpp-tools", ft = { "c", "cpp" } },

  { "p00f/clangd_extensions.nvim", ft = { "c", "cpp" } },

  { "plasticboy/vim-markdown", ft = "markdown" },

  { "jakewvincent/mkdnflow.nvim", ft = "markdown", rocks = "luautf8" },

  { "iamcco/markdown-preview.nvim", ft = "markdown", build = "cd app && yarn install" },

  { "mklabs/vim-json", ft = "json" },

  { "cespare/vim-toml", ft = "toml" },

  { "othree/html5.vim", ft = "html" },

  { "matveyt/vim-qmake", ft = "pro" },

  { "folke/lua-dev.nvim", ft = "lua", branch = "main" },

  { "rafamadriz/friendly-snippets", branch = "main" },

  { "chiel92/vim-autoformat", event = "VeryLazy" },
}
