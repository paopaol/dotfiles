vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.guifont = "ZedMono NFP:h11"
vim.o.pumheight = 10
vim.o.numberwidth = 3
-- 显示左侧图标指示列
vim.g.bookmark_sign = 'B'
vim.g.bookmark_annotation_sign = 'A'
vim.o.signcolumn = "yes"
vim.o.foldmethod = "manual"
vim.o.cursorline = true
vim.o.cursorcolumn = true
-- jk移动时光标下上方保留3行
vim.o.scrolloff = 1
vim.o.sidescrolloff = 1
vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.autowriteall = true
vim.o.relativenumber = true
vim.o.fileencodings = "utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin"
vim.o.fileformats = "unix,dos,mac"
vim.o.number = true
vim.o.autoread = true
vim.o.hlsearch = false
vim.o.wrap = false
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
vim.o.background = "dark"
vim.o.autoindent = true
vim.o.autochdir = false
vim.o.smartindent = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.backspace = "indent,eol,start"
vim.o.clipboard = "unnamedplus"
vim.o.shortmess = "filnxtToOFcI"
vim.g.python3_host_prog = "/home/jz/.env/python3/bin/python3"
vim.g.vim_markdown_folding_disabled = 1
vim.opt.jumpoptions:append("stack")
vim.cmd("syntax off")
vim.opt.mouse = "" -- 禁用鼠标
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "powershell"
end
