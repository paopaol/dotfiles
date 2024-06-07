local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeySh = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { utils.format_buffer, "formatting", buffer = buf },
    }
  })
end

vim.cmd([[
augroup py_grp
  autocmd!
  autocmd FileType bash,sh  lua whichkeySh()
augroup END
]])
