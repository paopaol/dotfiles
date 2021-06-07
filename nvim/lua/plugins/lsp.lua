local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		'documentation',
-- 		'detail',
-- 		'additionalTextEdits',
-- 	}
-- }

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
end

local servers = { "clangd", "rust_analyzer", "tsserver"}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { on_attach = on_attach}
end

require('lspconfig').clangd.setup({
    cmd = {"clangd", "--clang-tidy","-j=1", "--header-insertion=never", "--completion-style=detailed"};
    capabilities = capabilities 
})

require('lspconfig').cmake.setup({
    capabilities = capabilities 
})


require('lspconfig').tsserver.setup({
    cmd = {"/root/.local/share/nvim/lspinstall/typescript/./node_modules/.bin/typescript-language-server", "--stdio"},
    capabilities = capabilities 
})


