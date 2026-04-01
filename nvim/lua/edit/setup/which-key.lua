return {
  {
    "folke/which-key.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        win = { no_overlap = false, padding = { 1, 2 }, title = true, title_pos = "center", zindex = 1000, bo = {}, wo = {}, },
        plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = false,
        },
        show_keys = true,
        show_help = true,
      })
    end,
  },
}
