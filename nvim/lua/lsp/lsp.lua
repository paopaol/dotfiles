local util = require("lspconfig/util")
local base_utils = require('base.utils')

-- propgress
require("fidget").setup({})

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

local function disable_diagnostic_proto(_, bufnr)
  if vim.api.nvim_get_option_value("filetype", { buf = bufnr }) == "proto" then
    return false
  end
  return true
end

local lsphandlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, height = 15, width = 100 }),
  ["workspace/semanticTokens/refresh"] = nil,
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = disable_diagnostic_proto,
      virtual_text = false,
      update_in_insert = false,
      severity_sort = false,
      signs = disable_diagnostic_proto,
    }
  )
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup({})
require("lspconfig").lua_ls.setup({
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



require("lspconfig").cmake.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})

local augroup_in = vim.api.nvim_create_augroup("toggle_attach_in", {})
local augroup_out = vim.api.nvim_create_augroup("toggle_attach_out", {})

require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "-j",
    "1",
    "--background-index",
    "--background-index-priority=background",
    "--pch-storage=memory",
    "--log=error",
    "--clang-tidy",
    "--header-insertion=never",
    "--compile-commands-dir=build",
    "--completion-style=detailed",
    "--limit-results=20",
  },
  handlers = lsphandlers,
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    client.server_capabilities.semanticTokensProvider = false
    client.config.capabilities.workspace.semanticTokens.refreshSupport = false
    client.config.capabilities.textDocument.codeAction.codeActionLiteralSupport.codeActionKind.valueSet = { "", "Empty",
      "QuickFix", "Refactor", "RefactorExtract", "RefactorInline", "RefactorRewrite", "Source", "SourceOrganizeImports",
      "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source",
      "source.organizeImports" }
    client.config.capabilities.textDocument.codeAction.dynamicRegistration = false
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})




require("lspconfig").marksman.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern(".git", ".projectile"),
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})

require("lspconfig").taplo.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern(".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})


require("lspconfig").tsserver.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern(".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})

require("lspconfig").gopls.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern(".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})


require("lspconfig").pyright.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern(".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      }
    }
  },
})

require 'lspconfig'.bashls.setup {}
