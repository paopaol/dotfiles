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

require("clangd_extensions").setup {
  server = {
    cmd = {
      "clangd",
      "--j=1",
      -- "--background-index",
      -- "--background-index-priority=background",
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
  },
  extensions = {
    autoSetHints = false,
    inlay_hints = {
      -- inline = vim.fn.has("nvim-0.10") == 1,
      inline = false,
      only_current_line = false,
      only_current_line_autocmd = "CursorHold",
      show_parameter_hints = false,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
      priority = 100,
    },
    ast = {
      role_icons = {
        type = "🄣",
        declaration = "🄓",
        expression = "🄔",
        statement = ";",
        specifier = "🄢",
        ["template argument"] = "🆃",
      },
      kind_icons = {
        Compound = "🄲",
        Recovery = "🅁",
        TranslationUnit = "🅄",
        PackExpansion = "🄿",
        TemplateTypeParm = "🅃",
        TemplateTemplateParm = "🅃",
        TemplateParamObject = "🅃",
      },
      highlights = {
        detail = "Comment",
      },
    },
    memory_usage = {
      border = "none",
    },
    symbol_info = {
      border = "none",
    },
  },
}

-- require("lspconfig").clangd.setup({
--   cmd = {
--     "clangd",
--     "--j=1",
--     "--background-index",
--     "--background-index-priority=background",
--     "--pch-storage=memory",
--     "--log=error",
--     "--clang-tidy",
--     "--header-insertion=never",
--     "--compile-commands-dir=build",
--     "--completion-style=detailed",
--     "--limit-results=20",
--   },
--   handlers = lsphandlers,
--   root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
--   on_attach = function(_, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   end,
-- })

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

require("lspconfig").gopls.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern("compile_commands.json", ".git", ".projectile"),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})


require("lspconfig").pyright.setup({
  handlers = lsphandlers,
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".projectile"),
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
