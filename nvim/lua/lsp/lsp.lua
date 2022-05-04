local util = require 'lspconfig/util'
local lsp_installer = require("nvim-lsp-installer")

-- propgress
require "fidget".setup {}

lsp_installer.on_server_ready(function(server)
	local opts = {}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	opts.capabilities = capabilities
	opts.root_dir = util.root_pattern("compile_commands.json",
		"compile_flags.txt", ".git", ".projectile",
		".svn")
	opts.on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	end

	if server.name == "cmake" then
		opts.filetypes = { 'cmake' }
	elseif server.name == "sumneko_lua" then
		opts = require("lua-dev").setup({})
		opts.settings.Lua.format = {
			enable = true,
			defaultConfig = {
				indent_style = 'space',
				indent_size = "2",
			}
		}
	elseif server.name == "clangd" then
		opts.cmd = {
			"clangd", "--clang-tidy", "-j=1", "--header-insertion=never", "--compile-commands-dir=build",
			"--completion-style=detailed"
		}
	end
	server:setup(opts)
end)
