vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.cindent = true

vim.treesitter.start()

local utils = require("base.utils")
require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
})
