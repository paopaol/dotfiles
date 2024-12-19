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
  -- ["workspace/semanticTokens/refresh"] = nil,
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

local function root()
  local util = require("lspconfig/util")
  return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile", "Cargo.toml")
end

local function on_attach(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
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
  }
})


require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "-j",
    "1",
    "--background-index",
    "--background-index-priority=low",
    "--pch-storage=disk",
    "--log=error",
    "--clang-tidy",
    "--header-insertion=never",
    "--compile-commands-dir=build",
    "--completion-style=detailed",
    "--limit-results=20",
  },
  handlers = lsphandlers,
  root_dir = root(),
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})


require("lspconfig").pyright.setup({
  handlers = lsphandlers,
  root_dir = root(),
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      }
    }
  }
})

require 'lspconfig'.rust_analyzer.setup {
  handlers = lsphandlers,
  root_dir = root(),
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      }
    }
  }
}


-- require("lspconfig").cmake.setup({ handlers = lsphandlers, root_dir = root(), on_attach = on_attach })
require("lspconfig").marksman.setup({ handlers = lsphandlers, root_dir = root(), on_attach = on_attach })
require("lspconfig").taplo.setup({ handlers = lsphandlers, root_dir = root(), on_attach = on_attach })
require("lspconfig").tsserver.setup({ handlers = lsphandlers, root_dir = root(), on_attach = on_attach })
require("lspconfig").gopls.setup({ handlers = lsphandlers, root_dir = root(), on_attach = on_attach })
require 'lspconfig'.bashls.setup { handlers = lsphandlers, root_dir = root(), on_attach = on_attach }
require 'lspconfig'.jdtls.setup { handlers = lsphandlers, root_dir = root(), on_attach = on_attach }


local configs = require("lspconfig.configs")
local nvim_lsp = require("lspconfig")
require 'lspconfig'.neocmake.setup {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  root_dir = function(fname)
    return nvim_lsp.util.find_git_ancestor(fname)
  end,
  single_file_support = true, -- suggested
  on_attach = on_attach,      -- on_attach is the on_attach function you defined
  init_options = {
    format = {
      enable = false
    },
    scan_cmake_in_package = true -- default is true
  }
}
