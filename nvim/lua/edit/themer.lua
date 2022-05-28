-- require("themer").setup({
--   colorscheme = "dracula", -- default colorscheme
--   transparent = false,
--   term_colors = false,
--   dim_inactive = false,
--   disable_telescope_themes = {},
--   styles = {
--     heading = {
--       h1 = {},
--       h2 = {},
--     },
--     ["function"] = {},
--     functionBuiltIn = {},
--     variable = {},
--     variableBuiltIn = {},
--     include = {},
--     identifier = {},
--     keyword = {},
--     keywordBuiltIn = {},
--     struct = {},
--     string = {},
--     parameter = {},
--     field = {},
--     type = {},
--     typeBuiltIn = {},
--     property = {},
--     comment = { style = 'italic' },
--     punctuation = {},
--     constructor = {},
--     operator = {},
--     constant = {},
--     constantBuiltIn = {},
--     todo = { style = 'italic' },
--     character = {},
--     conditional = {},
--     number = { style = 'italic' },
--     statement = {},
--     uri = {},
--     diagnostic = {
--       underline = {
--         error = {},
--         warn = {},
--         info = {},
--         hint = {},
--       },
--       virtual_text = {
--         error = {},
--         warn = {},
--         info = {},
--         hint = {},
--       },
--     },
--   },
--   remaps = {
--     palette = {},
--     -- per colorscheme palette remaps, for example:
--     -- remaps.palette = {
--     --     rose_pine = {
--     --     	fg = "#000000"
--     --     }
--     -- },
--     -- remaps.highlights = {
--     --     rose_pine = {
--     --	base = {
--     --     	  Normal = { bg = "#000000" }
--     --	},
--     --     }
--     -- },
--     --
--     -- Also you can do remaps.highlights.globals  for global highlight remaps
--     highlights = {
--       -- monokai_pro = {
--       -- 	base = {
--       -- 		Normal = { bg = "#ffffff" }
--       -- 	},
--       -- }
--     },
--   },
--
--   langs = {
--     html = true,
--     md = true,
--   },
--
--   plugins = {
--     treesitter = true,
--     indentline = true,
--     barbar = true,
--     bufferline = true,
--     cmp = true,
--     gitsigns = true,
--     lsp = true,
--     telescope = true,
--   },
--   enable_installer = false, -- enable installer module
-- })
--
-- require("telescope").load_extension("themes")

vim.g.starry_italic_comments = true
vim.g.starry_italic_string = true
vim.g.starry_italic_keywords = false
vim.g.starry_italic_functions = false
vim.g.starry_italic_variables = true
vim.g.starry_contrast = true
vim.g.starry_borders = true
vim.g.starry_disable_background = false
vim.g.starry_style_fix = false --disable random loading
vim.g.starry_style = "moonlight" --load moonlight everytime or
vim.g.starry_darker_contrast = true
vim.g.starry_deep_black = false --OLED deep black
vim.g.starry_italic_keywords = false
vim.g.starry_italic_functions = false
vim.g.starry_set_hl = false -- Note: enable for nvim 0.6+, it is faster (loading time down to 4~6s from 7~11s), but it does
-- not overwrite old values and may has some side effects
vim.g.starry_daylight_switch = true --this allow using brighter color
--" other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue

vim.cmd([[ colorscheme monokai ]])


-- require("github-theme").setup({
-- 	theme_style = "light",
-- 	function_style = "italic",
-- 	sidebars = { "qf", "vista_kind", "terminal", "packer" },
--
-- 	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- 	colors = { hint = "orange", error = "#ff0000" },
--
-- 	-- Overwrite the highlight groups
-- 	overrides = function(c)
-- 		return {
-- 			htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
-- 			DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
-- 			-- this will remove the highlight groups
-- 			TSField = {},
-- 		}
-- 	end
-- })
