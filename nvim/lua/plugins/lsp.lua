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

-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
-- local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name ..
--                            "/lua-language-server"
local sumneko_binary =
    "/home/jz/.local/share/nvim/lspinstall/lua/./sumneko-lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = "/opt/nvim-linux64/share/nvim/runtime/lua/"
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}
