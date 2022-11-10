local wk = require("which-key")
local utils = require("base.utils")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

_G.whichkeyrXml = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd("set shiftwidth=1")

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { command("Autoformat"), "formatting", buffer = buf },
    },
    ["<tab>"] = { command("normal! za"), "expand", buffer = buf },
  })
end
vim.cmd([[ autocmd FileType xml,html  lua whichkeyrXml() ]])

_G.whichkeyrPrettier = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { utils.format_buffer, "formatting", buffer = buf },
    },
  })
end

vim.cmd([[ autocmd FileType json,css,html,javascript,yaml,vue,typescript,toml lua whichkeyrPrettier() ]])
vim.cmd([[
	autocmd FileType xml set tabstop=2
]])

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
    filetypes = { "html" , "xml" },
  }
}
-- OR
require('nvim-ts-autotag').setup({
  filetypes = { "html" , "xml" },
})
