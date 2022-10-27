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
        "toml",
      },
      -- prefer_local = "node_modules/.bin",
    }),
  },
})
