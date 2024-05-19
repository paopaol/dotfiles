local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeyGoCmake = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { utils.format_buffer, "formatting", buffer = buf },
    },
  })
end

vim.cmd([[
augroup go_grp
  autocmd!
  autocmd FileType cmake,go  lua whichkeyGoCmake()
  autocmd FileType cmake,go  set tabstop=2
augroup END
]])
