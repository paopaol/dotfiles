local wk = require("which-key")
local utils = require('base.utils')

local function command(cmd) return function() vim.cmd(cmd) end end

_G.whichkeyrLua = function()
	vim.bo.shiftwidth = 2
	vim.o.tabstop = 2
  vim.bo.expandtab = true

	local buf = vim.api.nvim_get_current_buf()

	wk.register({
		["<localleader>"] = {
			name = "major",
			[","] = { utils.format_buffer, "formatting", buffer = buf },
			["r"] = { command("luafile %"), "run current file", buffer = buf }
		}
	})
end
vim.cmd(([[]]))

vim.cmd([[
augroup lua_grp
  autocmd!
  autocmd FileType lua  lua whichkeyrLua() 
augroup END
]])
