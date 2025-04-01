return {
  { "hrsh7th/cmp-nvim-lsp",                event = "VeryLazy" },

  { "hrsh7th/cmp-path",                    event = "VeryLazy" },

  { "paopaol/cmp-doxygen",                 event = "VeryLazy" },

  { "hrsh7th/cmp-buffer",                  event = "VeryLazy" },

  { "saadparwaiz1/cmp_luasnip",            event = "VeryLazy" },

  { "hrsh7th/cmp-nvim-lsp-signature-help", event = "VeryLazy" },

  { "hrsh7th/cmp-cmdline",                 event = "VeryLazy" },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "paopaol/cmp-doxygen",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
    },
    config = require("completion.setup.cmp").config
  },
}
