return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = require("completion.setup.blink-cmp").keymap,
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true },
        list = {
          max_items = 15,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            opts = {
              get_cwd = function(context)
                return vim.fn.expand("#" .. context.bufnr .. ":p:h")
              end,
              show_hidden_files_by_default = true,
            },
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
    },
    opts_extend = { "sources.default" },
  },
}
