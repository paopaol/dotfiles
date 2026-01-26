local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeySh = function()
  wk.add({
    { "<localleader>,", utils.format_buffer, desc = "formatting" },
  })
end

vim.cmd([[
augroup sh_grp
  autocmd!
  autocmd FileType bash,sh lua whichkeySh()
augroup END
]])
