local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'


startify.section.header.val = {
	[[███████╗ ███╗   ███╗  █████╗   ██████╗ ███████╗]],
	[[██╔════╝ ████╗ ████║ ██╔══██╗ ██╔════╝ ██╔════╝]],
	[[█████╗   ██╔████╔██║ ███████║ ██║      ███████╗]],
	[[██╔══╝   ██║╚██╔╝██║ ██╔══██║ ██║      ╚════██║]],
	[[███████╗ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗ ███████║]],
	[[╚══════╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝ ╚══════╝]],
}
startify.section.top_buttons.val = {
	startify.button("e", "  New file", ":ene <BAR> startinsert <CR>", nil),
}
-- disable MRU
startify.section.mru.val = { { type = "padding", val = 0 } }
-- disable MRU cwd
startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
-- disable nvim_web_devicons
startify.nvim_web_devicons.enabled = true
startify.nvim_web_devicons.highlight = true
-- startify.nvim_web_devicons.highlight = 'Keyword'
--
startify.section.bottom_buttons.val = {
	startify.button("q", "  Quit NVIM", ":qa<CR>", nil),
}
startify.section.footer = {
	{ type = "text", val = "footer" },
}
-- ignore filetypes in MRU
startify.mru_opts.ignore = function(path, ext)
	return (string.find(path, "COMMIT_EDITMSG"))
			or (vim.tbl_contains(nil, ext))
end
alpha.setup(startify.config)
