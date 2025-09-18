return {
	{
		'olimorris/onedarkpro.nvim',
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				colors = {
					cursorline =
					"#9B0000" -- This is optional. The default cursorline color is based on the background
				},
				options = {
					cursorline = false
				}
			})
		end
	},

	{ 'Mofiqul/dracula.nvim',                config = function() require("dracula").setup() end },

	{ 'polirritmico/monokai-nightasty.nvim', },

	{ "folke/tokyonight.nvim",               opts = { style = "moon" }, },

	{ "ofirgall/ofirkai.nvim",               config = true },

	{ "nyoom-engineering/oxocarbon.nvim", },

	{ "uloco/bluloco.nvim",                  dependencies = { 'rktjmp/lush.nvim' } },

	{ "sekke276/dark_flat.nvim", },

	{
		"askfiy/visual_studio_code",
		event = "VeryLazy",
		config = function() require("visual_studio_code").setup({ mode = "dark" }) end,
	},

	{ "EdenEast/nightfox.nvim", event = "VeryLazy", config = require('colors.setup.nightfox').config },
}
