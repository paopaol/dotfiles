return {
  { "hrsh7th/cmp-nvim-lsp",                branch = "main",                        lazy = true },
  { "hrsh7th/cmp-path",                    branch = "main",                        lazy = false },
  { "hrsh7th/nvim-cmp",                    branch = "main", },
  { "hrsh7th/cmp-buffer",                  branch = "main",                        lazy = false },
  -- { "dcampos/cmp-emmet-vim",               lazy = true },
  { "saadparwaiz1/cmp_luasnip",            lazy = false },
  { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
  { "hrsh7th/cmp-cmdline", },
  { "paopaol/cmp-doxygen",                 dependencies = { "hrsh7th/nvim-cmp", }, event = "VeryLazy" },
}
