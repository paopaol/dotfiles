vim.o.guifont = "DejaVu Sans Mono:h15"

vim.o.pumheight = 10
vim.o.numberwidth = 3
-- 显示左侧图标指示列
vim.o.signcolumn = "yes"
vim.o.foldmethod = "manual"
-- vim.o.cursorline = true
-- jk移动时光标下上方保留3行
vim.o.scrolloff = 1
vim.o.sidescrolloff = 1
vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.autowriteall = true
vim.o.relativenumber = true
vim.o.fileencodings = "utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin"
vim.o.fileformats = "unix,dos,mac"
vim.o.encoding = "utf-8"
vim.o.number = true
-- vim.o.autosave = 30
vim.o.autoread = true
vim.o.hlsearch = false
vim.o.wrap = false
-- vim.o.t_ut = ''
vim.o.compatible = false
vim.o.hidden = true
-- Some servers have issues with backup files, see #649.
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- Give more space for displaying messages.
vim.o.cmdheight = 1
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable |
-- delays and poor user experience.
vim.o.updatetime = 4000
-- vim.o.shortmess+= 'c'
vim.o.background = "dark"
vim.o.autoindent = true
vim.o.autochdir = true
vim.o.smartindent = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.backspace = "indent,eol,start"
vim.o.rnu = true
vim.o.clipboard = "unnamedplus"
vim.o.shortmess = "filnxtToOFcI"


vim.g.python3_host_prog = "/opt/rh/rh-python38/root/bin/python3"

---external plugins
require("auto-save").setup {
  debounce_delay = 1000,
}
vim.g.interestingWordsDefaultMappings = 0
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_textobj_parameter_mapping = "a"
vim.g.BufKillCreateMappings = 0
vim.g.rooter_patterns = { ".projectile", ".git/" }
vim.g.autocwd_patternwd_pairs = { { "*", "%:p:h" } }


vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qfreplace',
  callback = function()
    vim.g.auto_save = 0
  end,
})


_G.toggleCursor = function()
  vim.cmd [[
	  set cursorline!
	  set cursorcolumn!
  ]]
end

vim.cmd([[
augroup setup_grp
  autocmd!
  let mapleader = "\<space>"
  let maplocalleader = ","
  au FocusGained * :checktime
  syntax on
  autocmd FileType bat if &modifiable|setlocal fileformat=dos|endif
  autocmd InsertLeave * lua toggleCursor()
  autocmd InsertEnter * lua toggleCursor()
augroup END
]])

require("messages").setup()
require('fix_clipboard').setup()

-- vim.cmd [[
-- let s:clip = '/mnt/c/Windows/System32/clip.exe'
-- if executable(s:clip)
--     augroup WSLYank
--         autocmd!
--         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--
--     augroup END
-- endif
--
-- ]]
--
-- if vim.fn.has("wsl") == 1 then
--   vim.g.clipboard = {
--     name = "win32yank-wsl",
--     copy = {
--       ["+"] = 'win32yank -i --crlf',
--       ["*"] = 'win32yank -i --crlf',
--     },
--     paste = {
--       ["+"] = 'win32yank -o --lf',
--       ["*"] = 'win32yank -o --lf',
--     },
--     cache_enabled = 0,
--   }
-- end

require 'eyeliner'.setup {
  highlight_on_key = true,
  dim = true,
}

require("yanky").setup({
  highlight = {
    timer = 60,
  },
})
