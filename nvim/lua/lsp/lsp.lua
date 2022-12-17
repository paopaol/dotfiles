local util = require("lspconfig/util")

-- propgress
require("fidget").setup({})

require("e-kaput").setup({
	-- defaults
	enabled = true, -- true | false,  Enable EKaput.
	transparency = 0, -- 0 - 100 , transparecy percentage.
	borders = true, -- true | false, Borders.
	error_sign = "", -- Error sign.
	warning_sign = "", -- Warning sign.
	information_sign = "", -- Information sign.
	hint_sign = "", -- Hint sign.
})

vim.cmd([[
highlight link EKaputError LspDiagnosticsSignError
highlight link EKaputWarning LspDiagnosticsSignWarning
highlight link EKaputInformation LspDiagnosticsSignInformation
highlight link EKaputHint LspDiagnosticsSignHint
highlight link EKaputBorder LspDiagnosticsSignInformation
highlight link EKaputBackground NormalFloat
]])

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "|", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "|", "FloatBorder" },
}

local lsphandlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, height = 15, width = 100 }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

------------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup({})
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				}
			},
		},
	},
})


require('semantic').setup({})

require("lspconfig").cmake.setup({
	handlers = lsphandlers,
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	end,
})

require("lspconfig").clangd.setup({
	cmd = {
		"clangd",
		"-j=1",
		"--background-index-priority=low",
		"--pch-storage=memory",
		"--log=error",
		"--clang-tidy",
		"--header-insertion=never",
		"--compile-commands-dir=build",
		"--completion-style=detailed",
	},
	handlers = lsphandlers,
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		require('semantic').refresh()
	end,
})
require("lspconfig").marksman.setup({
	handlers = lsphandlers,
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
})

require("lspconfig").taplo.setup({
	handlers = lsphandlers,
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
})
