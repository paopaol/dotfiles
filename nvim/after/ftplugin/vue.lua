local utils = require("base.utils")
vim.treesitter.start()

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", mode = "nv", buffer = true },
})
