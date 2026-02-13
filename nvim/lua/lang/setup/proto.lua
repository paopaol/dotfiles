local wk = require("which-key")
local utils = require("base.utils")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("filetype_proto", { clear = true }),
  pattern = "proto",
  callback = function()
    wk.add({
      { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
    })
  end,
})
