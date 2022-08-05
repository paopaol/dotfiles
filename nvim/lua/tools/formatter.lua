-- require('formatter').setup({
--   logging = true,
--   filetype = {
--     cpp = {
--       function() return { exe = "clang-format", args = {}, stdin = true } end
--     },
--     json = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'
--           },
--           stdin = true
--         }
--       end
--     },
--     css = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--double-quote'
--           },
--           stdin = true
--         }
--       end
--     },
--     html = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--double-quote'
--           },
--           stdin = true
--         }
--       end
--     },
--     xml = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--tab-width',
--             '2', '--parser', 'xml'
--           },
--           stdin = true
--         }
--       end
--     },
--     rels = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             '--tab-width', '2', '--bracket-same-line', 'true',
--             '--xml-whitespace-sensitivity', 'ignore', '--parser', 'xml'
--           },
--           stdin = true
--         }
--       end
--     },
--     javascript = {
--       -- prettier
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--double-quote'
--           },
--           stdin = true
--         }
--       end
--     },
--     markdown = {
--       function()
--         return {
--           exe = "prettier",
--           args = {
--             "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--semi", "--arrow-parens always", "--tab-width 2", "--parser markdown"
--           },
--           stdin = true
--         }
--       end
--     },
--     lua = {
--       -- luafmt
--       function()
--         return { exe = "lua-format", args = { "--indent-width=2" }, stdin = true }
--       end
--     }
--   }
-- })
--
--

local formatting = require("null-ls").builtins.formatting
require("null-ls").setup({
  sources = {
    formatting.stylua,
    formatting.shfmt,
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "markdown",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
      },
      prefer_local = "node_modules/.bin",
    }),
  },
})
