return {
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      local npairs = require('nvim-autopairs')

      npairs.setup({
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
          end_key = 'e',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          hightlight = 'Search'
        },
        ignored_next_char = "[%w%.%(%)]" -- will ignore alphanumeric and `.` symbol

      })

      _G.MUtils = {}

      vim.g.completion_confirm_key = ""

      MUtils.completion_confirm = function()
        if vim.fn.pumvisible() ~= 0 then
          if vim.fn.complete_info()["selected"] ~= -1 then
            require 'completion'.confirmCompletion()
            return npairs.esc("<c-y>")
          else
            vim.api.nvim_select_popupmenu_item(0, false, false, {})
            require 'completion'.confirmCompletion()
            return npairs.esc("<c-n><c-y>")
          end
        else
          return npairs.autopairs_cr()
        end
      end
      vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()',
        { expr = true, noremap = true })
    end
  }
}
