local M = {}

function M.is_buffer_empty()
	-- Check whether the current buffer is empty
	return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
	-- Check if the windows width is greater than a given number of columns
	return vim.fn.winwidth(0) / 2 > cols
end

function M.open_current_file_use_qtcreator()
	vim.cmd(string.format("silent ! qtcreator -client %s &", vim.fn.expand("%")))
end

function M.uncolor_all_words()
	vim.cmd([[Interestingwords --remove_all]])
	vim.g.nohlsearch = true
end

function M.rootdir()
	return vim.fs.root(0, { '.projectile' })
end

function M.current_dir()
	return vim.fn.expand("%:h")
end

function M.keymap(mode, key, action)
	vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end

function M.insert_semicolon_end_of_line()
	local save_cursor = vim.fn.getcurpos()
	vim.cmd([[normal! A;]])
	vim.fn.setpos(".", save_cursor)
end

function M.command(cmd)
	return function()
		vim.cmd(cmd)
	end
end

function M.format_buffer()
	require("conform").format({ async = true, lsp_fallback = true })
end

function M.open200()
	if vim.fn.has("win32") then
		vim.cmd([[silent ! start \\192.168.0.200\共享文件目录\1.共享文件夹\6.临时文件\jinzhao]])
	else
		vim.cmd([[silent ! dolphin smb://192.168.0.200 &]])
	end
end

M.make_keymap = function(ft, name, keymap, config)
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup(name, { clear = true }),
		pattern = ft,
		callback = function()
			require("which-key").add(keymap)
		end,
	})

	if config then
		config()
	end
end

return M
