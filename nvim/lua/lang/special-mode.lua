local wk = require("which-key")
local jz = require("base.jz")

local quit_window = function()
  jz.close_current_buffer()
  vim.cmd([[wincmd c]])
end

_G.whichkeySpecial = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { quit_window, "tree", buffer = buf },
  })
end

vim.cmd([[ autocmd FileType man,help,fugitive lua whichkeySpecial() ]])
