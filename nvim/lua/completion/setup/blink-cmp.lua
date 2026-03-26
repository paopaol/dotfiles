vim.api.nvim_create_autocmd("User", {
  pattern = "visual_multi_exit",
  callback = function()
    local cmp = require("blink.cmp")
    vim.keymap.set("i", "<CR>", function()
      if cmp.is_visible() then
        cmp.select_and_accept()
        return ""
      else
        return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
      end
    end, { expr = true, silent = true })
  end,
})
vim.keymap.set({ "i", "s" }, "<Esc>", function()
  if vim.snippet.active() then
    vim.snippet.stop()
  end
  return "<Esc>"
end, { expr = true })

local M = {
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
    completion = { menu = { auto_show = true } },
  },
}

return M
