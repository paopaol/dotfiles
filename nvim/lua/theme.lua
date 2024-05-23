require('ofirkai').setup({})
require("newpaper").setup({
  style = "light"
})
require("onedarkpro").setup({
  colors = {
    cursorline = "#9B0000" -- This is optional. The default cursorline color is based on the background
  },
  options = {
    cursorline = false
  }
})
-- vim.cmd([[set background=dark]])
vim.cmd("colorscheme dracula")
