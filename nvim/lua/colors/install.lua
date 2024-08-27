return {
  --onedarkpro
  { 'olimorris/onedarkpro.nvim',           priority = 1000 },
  --dracula
  { 'Mofiqul/dracula.nvim',                lazy = false,    config = function() require("dracula").setup() end },
  --monokai
  { 'polirritmico/monokai-nightasty.nvim', priority = 1000, lazy = false },
  -- tokyonight
  { "folke/tokyonight.nvim",               lazy = false,    opts = { style = "moon" }, },
  -- nightfox
  { "EdenEast/nightfox.nvim",              lazy = false },
  --ofirkai
  { "ofirgall/ofirkai.nvim",               lazy = false },
  { "nyoom-engineering/oxocarbon.nvim",               lazy = false },
}
