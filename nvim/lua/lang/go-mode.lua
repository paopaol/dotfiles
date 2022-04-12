local wk = require("which-key")

vim.cmd(([[
autocmd FileType cmake,go  lua whichkeyrCmake()
autocmd FileType cmake,go  set tabstop=2
]]))
_G.whichkeyrCmake = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {vim.lsp.buf.formatting, "formatting", buffer = buf}
    }
  })
end
