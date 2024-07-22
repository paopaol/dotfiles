local wk = require("which-key")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

_G.whichkeyFugitive_local = function()
  wk.add({
    { "<localleader><C-t>", command("normal O"),  desc = "open with tab", },
    { "<localleader>gv",    command("normal gO"), desc = "open with vertical", },
    { "<localleader>gs",    command("normal o"),  desc = "open with split", },
  })
end

vim.cmd([[
augroup git_grp
  autocmd!
  autocmd FileType fugitive,git lua whichkeyFugitive_local()
augroup END
]])
