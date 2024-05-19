return {
  --onedarkpro
  { 'olimorris/onedarkpro.nvim',           priority = 1000 },
  --dracula
  { 'Mofiqul/dracula.nvim',                lazy = false,    config = function() require("dracula").setup() end },
  { 'yorik1984/newpaper.nvim',             lazy = false },
  --monokai
  { 'polirritmico/monokai-nightasty.nvim', priority = 1000, lazy = false },
  -- tokyonight
  { "folke/tokyonight.nvim",               lazy = false,    opts = { style = "moon" }, },
  -- nightfox
  { "EdenEast/nightfox.nvim",              lazy = false },
  --ofirkai
  { "ofirgall/ofirkai.nvim",               lazy = false },
}
