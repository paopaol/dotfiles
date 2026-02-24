local M = {
  keymap = {
    preset = "default",

    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },

    ["<CR>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.accept()
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
  cmdline = {
    keymap = {

      ["<C-k>"] = { "select_prev" },
      ["<C-j>"] = { "select_next" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<Tab>"] = { "accept" },
      ["<CR>"] = { "accept_and_enter", "fallback" },
    },
    completion = { menu = { auto_show = true } },
  },
}

return M
