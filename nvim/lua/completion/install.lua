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
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = require("completion.setup.blink-cmp").cmdline,
    },
    opts_extend = { "sources.default" },
  },
}
