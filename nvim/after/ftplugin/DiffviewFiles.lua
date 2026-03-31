local utils = require("base.utils")

require("which-key").add({
  { "q", utils.command("DiffviewClose"), desc = "quit", buffer = vim.api.nvim_get_current_buf() },
})
