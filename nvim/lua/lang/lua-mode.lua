local wk = require("which-key")

local function command(cmd) return function() vim.cmd(cmd) end end

vim.cmd(([[ autocmd FileType lua  lua whichkeyrLua() ]]))
_G.whichkeyrLua = function()
  vim.bo.shiftwidth = 2

  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { vim.lsp.buf.formatting, "formatting", buffer = buf },
      ["r"] = { command("luafile %"), "run current file", buffer = buf }
    }
  })
end
