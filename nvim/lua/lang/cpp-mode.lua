local wk = require("which-key")
local utils = require('base.utils')

local function command(cmd) return function() vim.cmd(cmd) end end

-- debug template
local template = {
	configurations = {
		Launch = {
			adapter = "vscode-cpptools",
			configuration = {
				request = "launch",
				program = "${workspaceRoot}/build/main",
				args = {},
				cwd = "${workspaceRoot}/build",
				environment = {},
				externalConsole = true,
				MIMode = "gdb",
				setupCommands = {
					{
						description = "Enable pretty-printing for gdb",
						text = "-enable-pretty-printing",
						ignoreFailures = true
					}
				}
			}
		},
		Attach = {
			adapter = "vscode-cpptools",
			configuration = {
				request = "attach",
				program = "<path to binary>",
				MIMode = "<lldb or gdb>"
			}
		}
	}
}

-- start debug or edit lanuch json
local start_debug = function()
	local root = string.format("%s/.vimspector.json", utils.rootdir())

	if vim.fn.filereadable(root) == 1 then
		vim.call('vimspector#Continue')
		return
	end

	local ft = vim.api.nvim_buf_get_option(0, 'filetype')
	print(ft)
	if ft == 'cpp' or ft == 'c' then
		vim.cmd(string.format("edit %s", root))
		vim.fn.append(vim.fn.line('$'), vim.fn.json_encode(template))
	end
end

_G.whichkeyrCpp = function()
	local buf = vim.api.nvim_get_current_buf()

	wk.register({
		["<f5>"] = { start_debug, "debug", buffer = buf },
		["<localleader>"] = {
			name = "major",

			[","] = { utils.format_buffer, "formatting", buffer = buf },
			["o"] = { command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf },
			["y"] = { command("CopyCppMethod"), "copy cpp method", buffer = buf },
			["p"] = { command("PasteCppMethod"), "paste cpp method", buffer = buf },
			["g"] = { command("TSCppDefineClassFunc"), "define class func", buffer = buf }
		}
	})
end

vim.cmd(([[
augroup filetype_cpp
  autocmd!
  autocmd FileType cpp,c setlocal commentstring=//\ %s
  autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab  
  autocmd FileType cpp,c lua whichkeyrCpp()
augroup END
]]))

-- require("clangd_extensions").setup {
--   server = {
--   },
--   extensions = {
--     -- defaults:
--     -- Automatically set inlay hints (type hints)
--     autoSetHints = true,
--     -- Whether to show hover actions inside the hover window
--     -- This overrides the default hover handler
--     hover_with_actions = true,
--     -- These apply to the default ClangdSetInlayHints command
--     inlay_hints = {
--       -- Only show inlay hints for the current line
--       only_current_line = false,
--       -- Event which triggers a refersh of the inlay hints.
--       -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--       -- not that this may cause  higher CPU usage.
--       -- This option is only respected when only_current_line and
--       -- autoSetHints both are true.
--       only_current_line_autocmd = "CursorHold",
--       -- whether to show parameter hints with the inlay hints or not
--       show_parameter_hints = true,
--       -- prefix for parameter hints
--       parameter_hints_prefix = "<- ",
--       -- prefix for all the other hints (type, chaining)
--       other_hints_prefix = "=> ",
--       -- whether to align to the length of the longest line in the file
--       max_len_align = false,
--       -- padding from the left if max_len_align is true
--       max_len_align_padding = 1,
--       -- whether to align to the extreme right or not
--       right_align = false,
--       -- padding from the right if right_align is true
--       right_align_padding = 7,
--       -- The color of the hints
--       highlight = "Comment",
--       -- The highlight group priority for extmark
--       priority = 100,
--     },
--     ast = {
--       role_icons = {
--         type = "",
--         declaration = "",
--         expression = "",
--         specifier = "",
--         statement = "",
--         ["template argument"] = "",
--       },
--
--       kind_icons = {
--         Compound = "",
--         Recovery = "",
--         TranslationUnit = "",
--         PackExpansion = "",
--         TemplateTypeParm = "",
--         TemplateTemplateParm = "",
--         TemplateParamObject = "",
--       },
--
--       highlights = {
--         detail = "Comment",
--       },
--       memory_usage = {
--         border = "none",
--       },
--       symbol_info = {
--         border = "none",
--       },
--     },
--   } }


-- require("cmake-tools").setup {
--   cmake_command = "cmake",
--   cmake_build_directory = "build",
--   cmake_build_type = "Debug",
--   cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
--   cmake_build_options = {},
--   cmake_console_size = 10, -- cmake output window height
--   cmake_show_console = "always", -- "always", "only_on_error"
--   cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
--   cmake_dap_open_command = require("dap").repl.open, -- optional
-- }
