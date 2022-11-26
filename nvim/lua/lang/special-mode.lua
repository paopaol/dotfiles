local wk = require("which-key")
local jz = require("base.jz")

local quit_window = function()
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

local close_buffer = function()
  pcall(jz.close_current_buffer)
end

_G.whichkeySpecial1 = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { quit_window, "quit", buffer = buf },
  })
end
vim.cmd([[ autocmd FileType man,fugitive,help lua whichkeySpecial1() ]])

_G.whichkeySpecial2 = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { close_buffer, "quit", buffer = buf },
  })
end

vim.cmd([[ autocmd FileType fugitiveblame,git lua whichkeySpecial2() ]])
