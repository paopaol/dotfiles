local wk = require("which-key")
local jz = require("base.jz")

local quit_window = function()
  jz.close_current_buffer()
  vim.cmd([[wincmd c]])
end

local close_buffer = function()
  jz.close_current_buffer()
end

_G.whichkeySpecial1 = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { quit_window, "quit", buffer = buf },
  })
end
vim.cmd([[ autocmd FileType man,help,fugitive lua whichkeySpecial1() ]])

_G.whichkeySpecial2 = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { close_buffer, "quit", buffer = buf },
  })
end

vim.cmd([[ autocmd FileType fugitiveblame,git lua whichkeySpecial2() ]])
