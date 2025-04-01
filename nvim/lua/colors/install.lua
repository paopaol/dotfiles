return {
  { 'olimorris/onedarkpro.nvim',           event = "VeryLazy", priority = 1000 },

  { 'Mofiqul/dracula.nvim',                event = "VeryLazy", config = function() require("dracula").setup() end },

  { 'polirritmico/monokai-nightasty.nvim', event = "VeryLazy" },

  { "folke/tokyonight.nvim",               event = "VeryLazy", opts = { style = "moon" }, },

  { "ofirgall/ofirkai.nvim",               event = "VeryLazy", },

  { "nyoom-engineering/oxocarbon.nvim",    event = "VeryLazy", },

  { "uloco/bluloco.nvim",                  event = "VeryLazy", dependencies = { 'rktjmp/lush.nvim' } },

  { "sekke276/dark_flat.nvim",             event = "VeryLazy" },

  {
    "askfiy/visual_studio_code",
    event = "VeryLazy",
    config = function() require("visual_studio_code").setup({ mode = "dark" }) end,
  },

  { "EdenEast/nightfox.nvim", event = "VeryLazy", config = require('colors.setup.nightfox').config },
}
