require('Comment').setup()

local U = require("Comment.utils")
local A = require("Comment.api")

function _G.___gdc(vmode)
	local range = U.get_region(vmode)
	local lines = U.get_lines(range)

	-- Copying the block
	local srow = range.erow
	vim.api.nvim_buf_set_lines(0, srow, srow, false, lines)

	-- Doing the comment
	A.comment_linewise_op(vmode)

	-- Move the cursor
	local erow = srow + 1
	local line = U.get_lines({ srow = srow, erow = erow })
	local _, col = U.grab_indent(line[1])
	vim.api.nvim_win_set_cursor(0, { erow, col })
end

