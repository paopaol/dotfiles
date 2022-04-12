local wk = require("which-key")

local function command(cmd) return function() vim.cmd(cmd) end end

local function format_before_save()
  vim.cmd('FormatWrite')
  vim.cmd('write')
end

vim.cmd(([[ autocmd FileType lua  lua whichkeyrLua() ]]))
_G.whichkeyrLua = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {format_before_save, "formatting", buffer = buf},
      ["r"] = {command("luafile %"), "run current file", buffer = buf}
    }
  })
end
