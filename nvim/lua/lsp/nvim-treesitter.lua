require 'nvim-treesitter.configs'.setup {
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
	},
	indent = { enable = false },
	autotag = { enable = true },
	-- ensure_installed = {'bash', 'css', 'html', 'rust', 'toml', 'yaml', 'cpp', 'c'},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = "gnn",
			node_incremental = "vv"
			-- scope_incremental = "grc",
			-- node_decremental = "grm"
		}
	},
	textobjects = {
		enable = true,
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner"

			}
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = { ["]]"] = "@function.outer", ["]c"] = "@class.outer" },
			goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
			goto_previous_start = {
				["[["] = "@function.outer",
				["[c"] = "@class.outer"
			},
			goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" }
		}
	},
	nt_cpp_tools = {
		enable = false,
		preview = {
			quit = 'q', -- optional keymapping for quit preview
			accept = '<tab>' -- optional keymapping for accept preview
		},
		custom_impl_commands = {
			TSCppImplWrite = {
				output_cb = require 'nvim-treesitter.nt-cpp-tools.output_handlers'.add_to_cpp
				-- output_cb = function(output, _)
				--   print(output)
				--   vim.fn.setreg(0, output)
				-- end
			}
			-- <custom_command> = { output_cb = <function (output_str, context)> }
		}
	}
}

require("treesitter-context").setup({ enable = true, throttle = true })
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

require("nvim-treesitter.parsers").list.xml = {
	install_info = {
		url = "https://github.com/Trivernis/tree-sitter-xml",
		files = { "src/parser.c" },
		generate_requires_npm = true,
		branch = "main",
	},
	filetype = "xml",
}

require('neorg').setup {
	load = {
		["core.defaults"] = {}
	}
}




vim.api.nvim_create_autocmd('FileType', {
	pattern = 'cpp,c',
	callback = function()
		vim.cmd([[TSDisable highlight]])
	end,
})
