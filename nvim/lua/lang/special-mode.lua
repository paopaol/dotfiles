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
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { quit_window, "quit", buffer = buf },
  })
end

_G.whichkeySpecial2 = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { close_buffer_and_quickfix, "quit", buffer = buf },
  })
end




_G.whichkeyFugitive = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["<tab>"] = { command("normal ="), "toggle diff", buffer = buf },
  })
end

_G.whichkeySpecialDiffView = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["q"] = { command("DiffviewClose"), "quit", buffer = buf },
  })
end

vim.cmd([[
augroup special_grp
  autocmd!
  autocmd FileType man,fugitive,help,git,checkhealth lua whichkeySpecial1() 
  autocmd FileType git lua whichkeySpecial2() 
  autocmd FileType fugitive lua whichkeyFugitive() 
  autocmd FileType DiffviewFiles lua whichkeySpecialDiffView() 
augroup END
]])
