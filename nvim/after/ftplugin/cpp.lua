vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

vim.treesitter.start()

local utils = require("base.utils")

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
  { "<localleader>o", utils.command("ClangdSwitchSourceHeader"), desc = "switch cc/h", buffer = true },
  { "<localleader>g", utils.command("TSCppDefineClassFunc"), desc = "define class func", buffer = true },
})
