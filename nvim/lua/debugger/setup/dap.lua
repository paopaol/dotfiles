local M = {}

local quit_window = function()
	pcall(vim.cmd, [[wincmd c]])
end


local opts = function()
	return {
		controls = {
			element = "repl",
			enabled = true,
			icons = {
				disconnect = "✕",
				pause = "▷",
				play = "▶",
				run_last = "⟲",
				step_back = "🗝",
				step_into = "→",
				step_out = "←",
				step_over = "↷",
				terminate = "■"
			}
		},
		mappings = {
			edit = "e",
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			repl = "r",
			toggle = "t",
		},
		icons = {
			collapsed = "c",
			current_frame = "c",
			expanded = "e"
		},
		floating = {
			border = "single",
			mappings = {
				close = { "q", "<Esc>" }
			}
		},
		force_buffers = true,
		layouts = { {
			elements = { {
				id = "scopes",
				size = 0.25
			}, {
				id = "breakpoints",
				size = 0.25
			}, {
				id = "stacks",
				size = 0.25
			}, {
				id = "watches",
				size = 0.25
			} },
			position = "right",
			size = 40
		}, {
			elements = { {
				id = "repl",
				size = 0.5
			}, {
				id = "console",
				size = 0.5
			} },
			position = "bottom",
			size = 0.3
		} },
	}
end


M.config = function()
	local dap = require("dap")

	dap.adapters.cppdbg = {
		id = 'cppdbg',
		type = 'executable',
		command = string.format('%s/mason/bin/OpenDebugAD7', vim.fn.stdpath('data')),
	}
	vim.fn.sign_define('DapBreakpoint',
		{ text = '●', texthl = '', linehl = 'DapUIBreakpointsCurrentLine', numhl = 'DapUILineNumber' })

	require("base.utils").make_keymap("dap-float", "dap-group", {
		{ "q", quit_window, desc = "quit", buffer = vim.api.nvim_get_current_buf() },
	})
end


M.hover = function()
	local widgets = require('dap.ui.widgets')
	widgets.hover()
end

M.preview = function()
	require('dap.ui.widgets').preview()
end

M.scopes = function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end

M.frames = function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end


return M
