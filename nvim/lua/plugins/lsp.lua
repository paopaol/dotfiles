local capabilities = vim.lsp.protocol.make_client_capabilities()
local util = require 'lspconfig/util'

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
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = {"clangd", "rust_analyzer", "tsserver"}
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end

require('lspconfig').clangd.setup({
  cmd = {
    "clangd", "--clang-tidy", "-j=1", "--header-insertion=never",
    "--completion-style=bundled"
  },
  capabilities = capabilities,
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt",
                               ".git", ".projectile")
})

require('lspconfig').cmake.setup({capabilities = capabilities})

require('lspconfig').tsserver.setup({
  cmd = {
    "/root/.local/share/nvim/lspinstall/typescript/./node_modules/.bin/typescript-language-server",
    "--stdio"
  },
  capabilities = capabilities
})

local runtime_path = vim.split(package.path, ';')
-- local runtime_path = vim.api.nvim_list_runtime_paths()
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {'/root/.local/share/nvim/lspinstall/lua/./sumneko-lua-language-server'},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        -- library = vim.api.nvim_get_runtime_file("lua/", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}
