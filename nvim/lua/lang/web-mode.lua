local wk = require("which-key")

local function command(cmd) return function() vim.cmd(cmd) end end

vim.cmd(([[ autocmd FileType xml,html  lua whichkeyrXml() ]]))
_G.whichkeyrXml = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('set shiftwidth=1')

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {command("Autoformat"), "formatting", buffer = buf}
    },
    ["<tab>"] = {command("normal! za"), "expand", buffer = buf}
  })
end

vim.cmd(
    ([[ autocmd FileType json,css,html,javascript,markdown,yaml,vue,typescript lua whichkeyrPrettier() ]]))
vim.cmd(([[
	autocmd FileType xml set tabstop=2
]]))

_G.whichkeyrPrettier = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {command("FormatWrite"), "formatting", buffer = buf}
    }
  })
end
