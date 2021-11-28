local util = require 'lspconfig/util'
local nvim_lsp = require 'lspconfig'
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
--
--
--

local on_attach = function(_, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = {"clangd", "rust_analyzer", "tsserver"}
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
--

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-------------------------------------------
-- clangd
-------------------------------------------
if not configs.clangd then
  configs.clangd = {
    default_config = {
      cmd = {
        "clangd", "--clang-tidy", "-j=1", "--header-insertion=never",
        "--completion-style=bundled"
      },
      filetypes = {'cpp', 'c'},
      capabilities = capabilities,
      root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt",
                                   ".git", ".projectile")
    }
  }
end
lspconfig.clangd.setup {}

-------------------------------------------
-- cmake
-------------------------------------------
if not configs.cmake then
  configs.cmake = {
    default_config = {
      cmd = {"cmake-language-server"},
      filetypes = {'cmake'},
      capabilities = capabilities,
      root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt",
                                   ".git", ".projectile")
    }
  }
end
lspconfig.cmake.setup {}

-------------------------------------------
-- lua
-------------------------------------------
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

if not configs.sumneko_lua then
  configs.sumneko_lua = {
    default_config = {
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      filetypes = {'lua'},
      capabilities = capabilities,
      root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt",
                                   ".git", ".projectile"),
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
  }
end
lspconfig.sumneko_lua.setup {}
