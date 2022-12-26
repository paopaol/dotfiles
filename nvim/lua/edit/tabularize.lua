local M = {}


M.tabularize_space = function()

end

M.tabularize_comma = function()
	vim.cmd([[Tabularize /,]])
end



return M
