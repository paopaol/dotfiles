local util = require 'lspconfig/util'
local lsp_installer = require("nvim-lsp-installer")

-- propgress
require"fidget".setup {}

lsp_installer.on_server_ready(function(server)
  local opts = {}

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  opts.capabilities = capabilities
  opts.root_dir = util.root_pattern("compile_commands.json",
                                    "compile_flags.txt", ".git", ".projectile",
                                    ".svn")
  opts.on_attach = function(client, bufnr)

    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    require("aerial").on_attach(client, bufnr)
    require"lsp.lsp_signature".on_attach_lsp_signature(bufnr)
  end

  if server.name == "cmake" then
    opts.filetypes = {'cmake'}
  elseif server.name == "sumneko_lua" then
    opts = require("lua-dev").setup({})
  elseif server.name == "clangd" then
    opts.cmd = {
      "clangd", "--clang-tidy", "-j=1", "--header-insertion=never",
      "--completion-style=detailed"
    }
  end
  server:setup(opts)
end)
