local wk = require("which-key")
local jz = require("base.jz")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

_G.whichkeyFugitive_local = function()
  local buf = vim.api.nvim_get_current_buf()
  wk.register({
    ["<C-t>"] = { command("normal O"), "open with tab", buffer = buf },
    ["gv"] = { command("normal gO"), "open with vertical", buffer = buf },
    ["gs"] = { command("normal o"), "open with split", buffer = buf },
  })
end
vim.cmd([[]])

vim.cmd([[
augroup git_grp
  autocmd!
  autocmd FileType fugitive,git lua whichkeyFugitive_local() 
augroup END
]])
