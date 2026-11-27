vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.guifont = "ZedMono NFP:h11"
vim.o.pumheight = 10
vim.o.numberwidth = 3
vim.g.bookmark_sign = "B"
vim.g.bookmark_annotation_sign = "A"
vim.o.signcolumn = "yes"
vim.o.foldmethod = "manual"
vim.o.cursorline = true
vim.o.cursorcolumn = true
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
-- 部分服务器对备份文件有问题，见 #649
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.cmdheight = 1
vim.o.updatetime = 4000
vim.o.background = "dark"
vim.o.autoindent = true
vim.o.autochdir = false
vim.o.smartindent = true
vim.o.completeopt = "menu,menuone,noselect"
vim.o.backspace = "indent,eol,start"
vim.o.clipboard = "unnamedplus"
vim.o.shortmess = "filnxtToOFcI"

if vim.fn.has("win32") == 0 then
  vim.g.python3_host_prog = "/home/jz/.env/python3/bin/python3"
end
vim.g.vim_markdown_folding_disabled = 1
-- view：C-o/C-i 返回时恢复原窗口视图（topline/折叠），否则只恢复光标位置，行会跑到屏幕下方
vim.opt.jumpoptions = "stack,view"
vim.cmd("syntax off")
vim.opt.mouse = ""
-- Windows 原生走 Neovim 自带剪贴板 provider（win32yank），OSC 52 在 Windows Terminal 不生效
if vim.fn.has("win32") == 0 then
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
end
