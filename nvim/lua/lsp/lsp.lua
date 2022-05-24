local util = require 'lspconfig/util'
local lsp_installer = require("nvim-lsp-installer")

-- propgress
require "fidget".setup {}

require('e-kaput').setup({
  -- defaults
  enabled = true, -- true | false,  Enable EKaput.
  transparency = 0, -- 0 - 100 , transparecy percentage.
  borders = true, -- true | false, Borders.
  error_sign = '', -- Error sign.
  warning_sign = '', -- Warning sign.
  information_sign = '', -- Information sign.
  hint_sign = '' -- Hint sign.
})

vim.cmd([[
  highlight link EKaputError LspDiagnosticsSignError
  highlight link EKaputWarning LspDiagnosticsSignWarning
  highlight link EKaputInformation LspDiagnosticsSignInformation
  highlight link EKaputHint LspDiagnosticsSignHint
  highlight link EKaputBorder LspDiagnosticsSignInformation
  highlight link EKaputBackground NormalFloat
]])


-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--   underline = true,
--   virtual_text = true
-- }
-- )
--
lsp_installer.on_server_ready(function(server)
  local opts = {}

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  opts.capabilities = capabilities
  opts.root_dir = util.root_pattern("compile_commands.json",
    "compile_flags.txt", ".git", ".projectile")
  opts.on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

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

  opts.handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  }

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

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = alse,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
