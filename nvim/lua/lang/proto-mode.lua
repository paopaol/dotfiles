local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeyrProto = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",

      [","] = { utils.format_buffer, "formatting", buffer = buf },
    },
  })
end

vim.cmd([[
augroup filetype_proto
autocmd!
autocmd FileType proto lua whichkeyrProto()
augroup END
]])
