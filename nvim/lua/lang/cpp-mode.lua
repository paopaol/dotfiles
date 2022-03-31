local wk = require("which-key")

local function command(cmd) return function() vim.cmd(cmd) end end

_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {vim.lsp.buf.formatting, "formatting", buffer = buf},
      ["o"] = {command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf},
      ["d"] = {command("Dox"), "doxgen", buffer = buf},
      ["y"] = {command("CopyCppMethod"), "copy cpp method", buffer = buf},
      ["p"] = {command("PasteCppMethod"), "paste cpp method", buffer = buf}
    }
  })
end

vim.cmd(([[
autocmd FileType cpp   lua whichkeyrCpp()
]]))
