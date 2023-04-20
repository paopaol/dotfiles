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
  { "|",   "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "|",   "FloatBorder" },
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

require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "--j=1",
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
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})

-- require("lspconfig").ccls.setup {
--   init_options = {
--     compilationDatabaseDirectory = string.format('%s/build', base_utils.rootdir()),
--     cache = {
--       directory = "/tmp/ccls"
--     },
--     highlight = { lsRanges = true },
--     index = {
--       threads = 1;
--     },
--     diagnostics = {
--       onSave = 1000
--     },
--     clang = {
--       extraArgs = {
--         "-isystem",
--         "/opt/rh/devtoolset-8/root/usr/include/c++/8",
--         "-isystem",
--         "/opt/rh/devtoolset-8/root/usr/include/c++/8/x86_64-redhat-linux"
--       },
--       excludeArgs = { "-frounding-math" };
--     };
--   },
--   handlers = lsphandlers,
--   root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
--   on_attach = function(_, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   end,
-- }



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


require("lspconfig").tsserver.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})

-- require("lspconfig").pyright.setup({
--   handlers = lsphandlers,
--   root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
--   on_attach = function(_, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   end,
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         diagnosticMode = 'workspace',
--         useLibraryCodeForTypes = true,
--       }
--     }
--   },
-- })

require 'lspconfig'.bashls.setup {}
