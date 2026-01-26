local wk = require("which-key")
local jz = require("base.jz")

local quit_window = function()
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

local close_buffer_and_quickfix = function()
  pcall(vim.cmd, [[cclose]])
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

_G.whichkeySpecial1 = function()
  wk.add({
    { "q", quit_window, desc = "quit", buffer = vim.api.nvim_get_current_buf() },
  })
end

_G.whichkeySpecial2 = function()
  wk.add({
    { "q", close_buffer_and_quickfix, desc = "quit", buffer = vim.api.nvim_get_current_buf() },
  })
end

_G.whichkeyFugitive = function()
  wk.add({
    { "<tab>", command("normal ="), desc = "toggle diff", buffer = vim.api.nvim_get_current_buf() },
  })
end

_G.whichkeySpecialDiffView = function()
  wk.add({
    { "q", command("DiffviewClose"), desc = "quit", buffer = vim.api.nvim_get_current_buf() },
  })
end

vim.cmd([[
augroup special_grp
  autocmd!
  autocmd FileType man,fugitive,fugitiveblame,help,git,checkhealth lua whichkeySpecial1()
  autocmd FileType git lua whichkeySpecial2()
  autocmd FileType fugitive lua whichkeyFugitive()
  autocmd FileType DiffviewFiles lua whichkeySpecialDiffView()
augroup END
]])
