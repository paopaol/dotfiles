return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        ["<C-n>"] = { "fallback" },
        ["<C-p>"] = { "fallback" },

        ["<CR>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_and_accept()
            end
          end,
          "fallback",
        },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<C-e>"] = false,
        ["<C-space>"] = {
          function(cmp)
            cmp.show({ providers = { "snippets" } })
          end,
        },
        ["<Tab>"] = {
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          "snippet_backward",
          "fallback",
        },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true },
        list = {
          max_items = 15,
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        menu = {
          auto_show = true,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      cmdline = {
        keymap = {
          ["<C-k>"] = { "select_prev" },
          ["<C-j>"] = { "select_next" },

          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },

          ["<Tab>"] = { "show_and_insert", "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev" },
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        completion = { menu = { auto_show = false } },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == ":" then
            return { "cmdline" }
          end
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          return {}
        end,
      },
    },
    opts_extend = { "sources.default" },
  },
}
