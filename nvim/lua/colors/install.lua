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
  { "nyoom-engineering/oxocarbon.nvim",    lazy = false },
  { "uloco/bluloco.nvim",                  lazy = false,    dependencies = { 'rktjmp/lush.nvim' } },
  {
    "askfiy/visual_studio_code",
    lazy = false,
    config = function() require("visual_studio_code").setup({ mode = "dark" }) end,
  },
  { "sekke276/dark_flat.nvim" }
}
