local wk = require("which-key")
local utils = require("base.utils")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

_G.whichkeyrXml = function()
  vim.cmd("set shiftwidth=1")

  wk.add({
    { "<localleader>,", command("Autoformat"), desc = "formatting" },
    { "<tab>",          command("normal! za"), desc = "expand",    buffer = vim.api.nvim_get_current_buf() },
  })
end

_G.whichkeyrPrettier = function()
  wk.add({
    { "<localleader>,", utils.format_buffer, desc = "formatting" },
  })
end


vim.cmd([[
augroup web_grp
  autocmd!
  autocmd FileType xml,html  lua whichkeyrXml()
  autocmd FileType json,css,html,javascript,yaml,vue,typescript,toml lua whichkeyrPrettier()
	autocmd FileType xml set tabstop=2
augroup END
]])

require('nvim-ts-autotag').setup({ filetypes = { "html", "xml" } })
