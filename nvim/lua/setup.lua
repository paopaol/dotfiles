vim.cmd([[
  let mapleader = "\<space>"
  let maplocalleader = ","
]])

vim.o.pumheight = 10
vim.o.numberwidth = 2
-- 显示左侧图标指示列
vim.signcolumn = 'yes'
vim.o.foldmethod = 'manual'
vim.o.cursorline = true
-- jk移动时光标下上方保留3行
vim.o.scrolloff = 3
vim.o.sidescrolloff = 3
vim.o.colorcolumn = '80'
vim.o.termguicolors = true
vim.o.autowriteall = true
vim.o.relativenumber = true
vim.o.fileencodings = 'utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin'
vim.o.encoding = 'utf-8'
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
vim.o.updatetime = 300
-- vim.o.shortmess+= 'c'
vim.o.background = 'dark'
vim.o.autoindent = true
vim.o.autochdir = true
vim.o.smartindent = true
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.backspace = 'indent,eol,start'
vim.o.rnu = true
vim.o.clipboard = 'unnamedplus'
vim.o.shortmess = 'filnxtToOFcI'

vim.cmd([[ au FocusGained * :checktime ]])

-- color
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1
vim.g.vscode_style = "light"
vim.g.vscode_transparent = 1
vim.g.vscode_italic_comment = 1
vim.cmd([[
  set background=light
  colorscheme dracula

  let g:material_style = 'lighter'
  let ayucolor="light"  " for light version of theme
  let g:github_comment_style = "italic"
  let g:github_keyword_style = "italic"
  let g:github_function_style = "italic"
  let g:github_variable_style = "italic"
]])

---external plugins
vim.g.auto_save = 1
vim.g.auto_save_silent = 1
vim.g.auto_save_events = {"InsertLeave", "TextChanged"}
vim.g.interestingWordsDefaultMappings = 0
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_textobj_parameter_mapping = 'a'
vim.g.BufKillCreateMappings = 0
vim.g.rooter_patterns = { '.projectile', '.git/', '.svn/' }

