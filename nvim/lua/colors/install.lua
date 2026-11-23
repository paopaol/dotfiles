return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        colors = {
          cursorline = "#9B0000", -- This is optional. The default cursorline color is based on the background
        },
        options = {
          cursorline = false,
        },
      })
    end,
  },

  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
      require("dracula").setup()
    end,
  },

  { "polirritmico/monokai-nightasty.nvim", lazy = true },

  { "folke/tokyonight.nvim", lazy = true, opts = { style = "moon" } },

  { "ofirgall/ofirkai.nvim", lazy = true, config = true },

  { "nyoom-engineering/oxocarbon.nvim", lazy = true },

  { "uloco/bluloco.nvim", lazy = true, dependencies = { "rktjmp/lush.nvim" } },

  { "sekke276/dark_flat.nvim", lazy = true },

  {
    "askfiy/visual_studio_code",
    lazy = true,
    config = function()
      require("visual_studio_code").setup({ mode = "dark" })
    end,
  },

  { "EdenEast/nightfox.nvim", lazy = true },
}
