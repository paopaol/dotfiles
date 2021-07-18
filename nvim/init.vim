
let $VIMHOME = fnamemodify(expand('<sfile>'), ':p')
let $VIMHOME = resolve($VIMHOME)
let $VIMHOME =  fnamemodify(expand($VIMHOME), ':p:h')
source $VIMHOME/core/base_setting.vim


"plug -----{{{
augroup plgu
	call plug#begin('~/.vim/plugged')
	Plug 'paopaol/telescope-ctags.nvim'
	Plug 'paopaol/telescope-vimsnip.nvim' , {'branch': 'main'}
	Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
	Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
	Plug 'akinsho/nvim-bufferline.lua'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kyazdani42/nvim-tree.lua'
	Plug 'folke/which-key.nvim', {'branch':'main'}
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall', {'branch':'main'}
	Plug 'windwp/nvim-autopairs'
	Plug 'MattesGroeger/vim-bookmarks'
	Plug 'tom-anders/telescope-vim-bookmarks.nvim', {'branch':'main'}
	Plug 'crispgm/telescope-heading.nvim', {'branch':'main'}
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'rafamadriz/friendly-snippets', {'branch':'main'}
	Plug 'nvim-lua/completion-nvim'
	Plug 'simrat39/symbols-outline.nvim'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'mhartington/formatter.nvim'
	Plug 'onsails/lspkind-nvim'
	Plug 'voldikss/vim-translator'
	Plug 'p00f/nvim-ts-rainbow'
    Plug 'glepnir/dashboard-nvim'
	"""colors
	Plug 'glepnir/zephyr-nvim', {'branch':'main'}
	Plug 'Mofiqul/vscode.nvim', {'branch': 'main'}
	Plug 'marko-cerovac/material.nvim', {'branch':'main'}
	Plug 'tanvirtin/monokai.nvim'
	"""

	Plug 'skanehira/preview-markdown.vim'
	Plug 'rhysd/accelerated-jk'
	Plug 'mhinz/vim-grepper'
	Plug 'paopaol/vim-terminal-help'
	Plug 'vim-scripts/DoxygenToolkit.vim'
	Plug 'plasticboy/vim-markdown'
	Plug 'terryma/vim-expand-region'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'easymotion/vim-easymotion'
	Plug 'haya14busa/incsearch.vim'
	Plug 'haya14busa/incsearch-easymotion.vim'
	Plug 'haya14busa/incsearch-fuzzy.vim'
	Plug 'mg979/vim-visual-multi'
	Plug 'pseewald/vim-anyfold'
	Plug 'mattn/emmet-vim'
	Plug 'justinmk/vim-sneak'
	Plug 'skywind3000/asynctasks.vim'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'tpope/vim-surround'
	Plug 'rakr/vim-one'
	" Plug 'mhinz/vim-startify'
	Plug 'rbgrouleff/bclose.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'lfv89/vim-interestingwords'
	Plug 'kana/vim-textobj-user'
	Plug 'sgur/vim-textobj-parameter'
	Plug 'rhysd/vim-textobj-anyblock'
	Plug 'tpope/vim-commentary'
	Plug 'thinca/vim-qfreplace'
	Plug 'markonm/traces.vim'
	Plug 'othree/html5.vim'
	Plug 'mklabs/vim-json'
	Plug 'kana/vim-textobj-line'
	Plug 'cespare/vim-toml'
	Plug 'itchyny/vim-cursorword'
	Plug 'puremourning/vimspector'
	Plug 'godlygeek/tabular'
	Plug 'AndrewRadev/sideways.vim'
	Plug 'rust-lang/rust.vim'
	call plug#end()
augroup END
"}}}


nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

""""""""vimspector{{{
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
" for normal mode - the word under the cursor
nmap <f12> <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <f12> <Plug>VimspectorBalloonEval
"""}}}

""startify{{{
"augroup startify
"	autocmd!
"	let g:emacs = [
"				\"███████╗ ███╗   ███╗  █████╗   ██████╗ ███████╗",
"				\"██╔════╝ ████╗ ████║ ██╔══██╗ ██╔════╝ ██╔════╝",
"				\"█████╗   ██╔████╔██║ ███████║ ██║      ███████╗",
"				\"██╔══╝   ██║╚██╔╝██║ ██╔══██║ ██║      ╚════██║",
"				\"███████╗ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗ ███████║",
"				\"╚══════╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝ ╚══════╝",
"				\]
"	let g:fuck_fuck = [
"				\"███████╗██╗   ██╗ ██████╗██╗  ██╗    ███████╗██╗   ██╗ ██████╗██╗  ██╗",
"				\"██╔════╝██║   ██║██╔════╝██║ ██╔╝    ██╔════╝██║   ██║██╔════╝██║ ██╔╝",
"				\"█████╗  ██║   ██║██║     █████╔╝     █████╗  ██║   ██║██║     █████╔╝ ",
"				\"██╔══╝  ██║   ██║██║     ██╔═██╗     ██╔══╝  ██║   ██║██║     ██╔═██╗ ",
"				\"██║     ╚██████╔╝╚██████╗██║  ██╗    ██║     ╚██████╔╝╚██████╗██║  ██╗",
"				\"╚═╝      ╚═════╝  ╚═════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝  ╚═════╝╚═╝  ╚═╝",
"				\]

"	let g:fuck = [
"				\"   ▄████████ ███    █▄   ▄████████    ▄█   ▄█▄ ",
"				\"  ███    ███ ███    ███ ███    ███   ███ ▄███▀ ",
"				\"  ███    █▀  ███    ███ ███    █▀    ███▐██▀   ",
"				\" ▄███▄▄▄     ███    ███ ███         ▄█████▀    ",
"				\"▀▀███▀▀▀     ███    ███ ███        ▀▀█████▄    ",
"				\"  ███        ███    ███ ███    █▄    ███▐██▄   ",
"				\"  ███        ███    ███ ███    ███   ███ ▀███▄ ",
"				\"  ███        ████████▀  ████████▀    ███   ▀█▀ ",
"				\"                                     ▀         ",
"				\]
"	let g:startify_custom_header =startify#center(g:fuck_fuck)
"augroup END
""}}}
" let g:dashboard_default_executive ='telescope'

"easymotion{{{
augroup easymotion
	function! s:config_easyfuzzymotion(...) abort
		return extend(copy({
					\   'converters': [incsearch#config#fuzzyword#converter()],
					\   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
					\   'keymap': {"\<CR>": '<Over>(easymotion)'},
					\   'is_expr': 0,
					\   'is_stay': 1
					\ }), get(a:, 1, {}))
	endfunction
	noremap <silent><expr> <C-s> incsearch#go(<SID>config_easyfuzzymotion())
augroup END
""}}}

"filetype file settings ---------------------{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
augroup filetype_cpp
	autocmd!
	autocmd FileType cpp,c set tabstop=4  
	autocmd FileType cpp,c set shiftwidth=4  
	autocmd FileType cpp,c set expandtab  
	autocmd FileType cpp,c set softtabstop=4 
augroup END
" }}}

"markdown {{{
augroup filetype_markdown
	autocmd!
	let g:vim_markdown_folding_disabled = 1
	let g:mkdp_browser = 'edge'
	" let g:mkdp_open_to_the_world = 1
augroup END
" }}}

"xml_html filetype_xml {{{
augroup filetype_xml
	autocmd!
	autocmd FileType xml    	set tabstop=2
augroup END
"}}}

"lspcxx_hl{{{
augroup lspcxx_hl
	autocmd!
	" let g:lsp_cxx_hl_light_bg = 1
	autocmd FileType cpp  highlight  LspCxxHlSymField ctermfg=Blue guifg=Green
augroup END
"}}}


"leaderf settings-------------------{{{
augroup leaderf
	autocmd!
	function! ProjectFiles() abort
		let root = asyncrun#get_root('%')
		execute ':Leaderf file --regexMode  ' . root . "\<CR>"
	endfunction

	function! ProjectFilesCurrentdir() abort
		let root = fnamemodify(expand('%'), ':p:h')
		execute ':Leaderf file --regexMode ' . root . "\<CR>"
	endfunction

	let g:Lf_RootMarkers = ['.projectile']
	let g:Lf_ShortcutF=''
	let g:Lf_ShortcutB=''
	let g:Lf_ShowRelativePath = 0
	let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
	let g:Lf_ShowDevIcons = 0
	let g:Lf_StlColorscheme = 'powerline'
augroup END
"  }}}

augroup which-key
	autocmd!

	autocmd BufNew * highlight WhichKeyFloat ctermbg=NONE ctermfg=NONE
augroup END

"commentary------------------{{{
augroup commentary
	autocmd!

	autocmd FileType cpp setlocal commentstring=//\ %s
augroup END
"}}}


"greper-----------{{{
augroup grepper
	autocmd!

	function! GrepperProjectSymbolAtPoint() abort
		execute ':Grepper -dir repo -cword -noprompt '
	endfunction

	function! GrepperCurrentDirectorySymbolAtPoint() abort
		execute ':Grepper  -cword -noprompt -dir cwd'
	endfunction

	function! GrepperProjectSymbol()abort
		execute ':Grepper -dir repo'
	endfunction

	function! GrepperCurrentBufferAtPoint() abort
		execute ':Grepper -buffer -cword -noprompt'
	endfunction

	function! GrepperCurrentBuffer() abort
		execute ':Grepper -buffer'
	endfunction


	runtime plugin/grepper.vim    " initialize g:grepper with default values
	let g:grepper.repo = ['.projectile', '.git']
	let g:grepper.tools = ['ag']
	let g:grepper.ag = { 'grepprg':'ag  --vimgrep -i' }
augroup END
"}}}

" AnyFold-----------{{{
augroup AnyFold
	autocmd!
	" autocmd Filetype * AnyFoldActivate
	" let g:anyfold_fold_comments=1
	" set foldlevel=0
	nnoremap zm :AnyFoldActivate<CR>zM
	vnoremap zm :AnyFoldActivate<CR>zM
	nnoremap zr zR
	vnoremap zr zR
augroup END
"}}}


"terminal----------{{{
augroup terminal
	autocmd!

	let g:terminal_key='<f3>'
	if has('win32')
		let g:terminal_shell='powershell.exe'
	endif
	let g:terminal_cwd = 2
	let g:terminal_height = 30
	autocmd TermOpen * setlocal nobuflisted
augroup END
"}}}

"""window settings---------{{{
augroup window
	autocmd!


	let g:material_style = 'lighter'
	colorscheme material

	map <A-j> <C-W>j
	map <A-k> <C-W>k
	map <A-h> <C-W>h
	map <A-l> <C-W>l

	nnoremap Q :cclose<CR>
	vnoremap Q :cclose<CR>

	cnoremap <C-a> <Home>

	nnoremap <C-b> <Left>
	inoremap <C-b> <Left>
	vnoremap <C-b> <Left>
	cnoremap <C-b> <Left>

	nnoremap <C-e> <End>a
	inoremap <C-e> <End>
	vnoremap <C-e> <End>a
	cnoremap <C-e> <End>a


	nnoremap <C-f> <Right>
	inoremap <C-f> <Right>
	vnoremap <C-f> <Right>
	cnoremap <C-f> <Right>

	cnoremap <C-j> <Down>
	inoremap <C-j> <Down>
	cnoremap <C-k> <Up>
	inoremap <C-k> <Up>
	nnoremap <C-j> 5j
	nnoremap <C-k> 5k




	"跳转到函数的参数"
	function! JumpRight() abort
		""先进行参数jump，如果成功，那么就不找"("了
		let save_cursor = getcurpos()
		:SidewaysJumpRight
		let cur_cursor = getcurpos()
		if save_cursor[1] != cur_cursor[1] || save_cursor[2] != cur_cursor[2]
			return
		endif
	endfunction


	function! BeginOfLine() abort
		call setpos('.', [0 , line('.'), 0])
	endfunction

	function! CursorForward()abort
		let current = getcurpos()
		let current[2] += 1
		call setpos('.', current)
	endfunction



	"跳转到函数的参数"
	function! JumpRight() abort
		""先进行参数jump，如果成功，那么就不找"("了
		let save_cursor = getcurpos()
		:SidewaysJumpRight
		let cur_cursor = getcurpos()
		if save_cursor[1] != cur_cursor[1] || save_cursor[2] != cur_cursor[2]
			return
		endif

		""""从行首查找("""""
		call BeginOfLine()
		let match_num = search('(', 'n', line('.'))
		if match_num == 0
			return
		endif
		call search('(', '', line('.'))

		let content = getline('.')
		let idx = stridx(content, "(") 
		if idx < 0
			return
		endif
		call CursorForward()
	endfunction

	""quick fix"
	nnoremap <F8> :cn<CR>zz
	nnoremap <F7> :cp<CR>zz

	""window resie
	nnoremap <A--> :resize -1<CR>
	nnoremap <A-=> :resize +1<CR>
	nnoremap <silent> <tab> :call JumpRight()<CR>
	nnoremap <silent> <S-tab> :SidewaysJumpRight<CR>
	nnoremap <silent> <A-<> :SidewaysLeft<CR>
	nnoremap <silent> <A->> :SidewaysRight<CR>
augroup END
"}}}

"asyncrun"""""""""""""""""""""""""""""{{{
augroup asyncrun
	autocmd!

	if has('win32')
		let g:asyncrun_encs = 'gbk'
	endif
	let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', '.projectile']
	let g:asyncrun_open=30
	let g:asyncrun_save=2
augroup END
"}}}



"vim settings -----------------{{{
augroup vimsettings
	autocmd!
	function! ImSelectEn()
		if has('win32')
			call system('im-select 1033')
		else
			" call system('ibus engine xkb:us::eng')
			call system('/mnt/c/Windows/System32/im-select.exe 1033')
		endif
	endfunction

	set termguicolors
	" In your init.lua or init.vim
	"highlight Pmenu ctermfg=NONE ctermbg=NONE  guibg=NONE guifg=NONE
	"highlight PmenuSel ctermfg=7 ctermbg=4 guibg=NONE guifg=NONE

	set relativenumber
	set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin
	set number
	"always show tab
	set showtabline=2
	let autosave=30
	set autoread
	set nohlsearch
	set nowrap
	set t_ut=
	"""""""""""

	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup
	set noswapfile

	" Give more space for displaying messages.
	set cmdheight=1

	" | Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable |
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c
	" set guioptions-=e



	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes
	set numberwidth=2
	set foldmethod=manual
	set cursorline
	set cursorcolumn
	set relativenumber
	set autoindent
	set autochdir
	set smartindent
    set completeopt=menuone,noinsert
	" set mouse=a

	set backspace=indent,eol,start
	set rnu

	set clipboard=unnamed
	set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
	set encoding=utf-8
	set bg=light
	set t_Co=256
	" set t_ut=
	" set term=screen-256color

	if has("autocmd")
		au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	endif
	""""""""'



	autocmd InsertLeave * call ImSelectEn()
	" nnoremap <ESC> <ESC>:call ImSelectEn()<CR>


	if has('nvim')
	else
		if has('win32')
			" set pythonthreedll=python38.dll
		else
			set pyxversion=3
		endif
	endif
	xnoremap > >gv
	xnoremap < <gv
	nnoremap <F2><F2> :<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	inoremap <F2><F2>   <C-o>:<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	vnoremap <F2><F2> :call Jz_insert_semicolon_end_of_line()<CR>
	" select block
	" vnoremap v a}o0
	tnoremap <Esc> <C-\><C-n>
	au FocusGained * :checktime
augroup END
"}}}



""""""""""functions{{{{
function! CmakeFormatCurrentFile() abort
	silent :w
	silent :!cmake-format  -i %
	silent :e!
endfunction



function! ProjectRelativeFilePath() abort
	let root = asyncrun#get_root('%')
	let absfile = fnamemodify(expand('%'),':p')
	if has('win32')
		let root = escape(root, '\')
	endif
	let relativePath = substitute(absfile, root, "pro", "")
	return relativePath
endfunction


function! Jz_insert_semicolon_end_of_line()
	let save_cursor = getcurpos()
	execute "normal! A;"
	call setpos('.', save_cursor)
endfunction

function! SaveBuf() abort
	if !&modifiable
		return
	endif
	if bufname('%') != ''
		execute  ':w'
	endif
endfunction

function! LspFormat() abort
	if &ft == 'cpp'
		execute ':Neoformat'
	elseif &ft == 'cmake'
		call CmakeFormatCurrentFile()
	else
		execute ':Format'
	endif
	call SaveBuf()
endfunction


function! CmakeBuild()abort
	let root = asyncrun#get_root('%')
	execute ':lcd ' . root . '/build'
	execute ':AsyncRun -cwd=<root>/build/ cmake --build <root>/build'
endfunction
"""""}}}





""""""""other{{{
let g:vim_textobj_parameter_mapping = 'a'
let g:rainbow_active = 1

let g:BufKillCreateMappings = 0
let g:rooter_patterns = ['.projectile', '.git/']
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>
""""""""}}}



""""""functions{{{
function! StartDebug() abort
	let root = asyncrun#get_root('%')
	if filereadable(root . '/.vimspector.json')
		:call vimspector#Continue()
		return
	else
		if &ft == 'cpp' || &ft == 'c'
			execute ':edit ' . root . '/.vimspector.json' 
			let cpp_config = ' {
						\"configurations": {
							\"Launch": {
								\"adapter": "vscode-cpptools",
								\"configuration": {
									\"request": "launch",
									\"program": "${workspaceRoot}/build/main",
									\"args": [],
									\"cwd": "${workspaceRoot}/build",
									\"environment": [],
									\"externalConsole": true,
									\"MIMode": "gdb",
									\"setupCommands": [ {
										\"description": "Enable pretty-printing for gdb",
										\"text": "-enable-pretty-printing",
										\"ignoreFailures": true } ] } },
										\"Attach": {
											\"adapter": "vscode-cpptools",
											\"configuration": {
												\"request": "attach",
												\"program": "<path to binary>",
												\"MIMode": "<lldb or gdb>" } } } } '
			call append(line('$'), cpp_config)
		endif
	endif
endfunction

function! Jz_get_signature_help() abort
	let result = CocAction("getHover")

	if len(result) == 0
		return
	endif


	let  signatures = split(result[0], "---")
	let header = matchlist(signatures[0], ' \(.\+\) `\(.\+\)`') 
	if header[1] == "function"
		let func = split(signatures[2], "\n")
		call remove(func, 0)
		call remove(func, len(func) - 1)
		echo func[0]
	elseif header[1] == "instance-method"
		let func = split(signatures[2], "\n")
		call remove(func, 0)
		if stridx(func[0],"//") >= 0
			call remove(func, 0)
		endif
		call remove(func, len(func) - 1)
		echo join(func, "")
	endif
endfunction


function! Uncolor_all_words() abort
	call UncolorAllWords()
	set nohlsearch
endfunction
"""""""""}}}}

let mapleader = "\<space>"
let maplocalleader = ","

lua << EOF
require('plugins.lsp')
require("bufferline").setup{}
require('plugins.bufferline')
require('plugins.status-line')
require('plugins.treesitter')
require('plugins.lspinstall')
require('plugins.telescope')
require('plugins.which-key')
require('nvim-autopairs').setup()
require('plugins.autopairs')
require('plugins.formatter')
require('plugins.lspkind')
require'telescope'.load_extension('ctags')
require'telescope'.load_extension('vimsnip')
require('telescope').load_extension('vim_bookmarks')
require('plugins.bookmarks')
require('plugins.rainbow')
require('plugins.nvim-treesitter')
require('plugins.symbols_outline')
require('plugins.dashboard-nvim')
EOF

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
let g:completion_trigger_on_delete = 1
" let g:completion_enable_snippet = 'vim-vsnip'

"""function{{{
function! TelescopeProjectFiles() abort
	let root = asyncrun#get_root('%')
	lua require('telescope.builtin').find_files{border = true, previewer = false, cwd = vim.call('asyncrun#get_root', '%') } 
endfunction

function! TelescopeSymbolsCurrentDirectory() abort
	lua require('telescope.builtin').grep_string{search_dirs = {"", "."}} 
endfunction

function! TelescopeSymbolsCurrentProjectAtPoint() abort
	let cword = expand('<cword>')
	if cword == ''
		return
	endif
	lua require('telescope.builtin').grep_string{cwd = vim.call('asyncrun#get_root', '%'),search_dirs = {"", "."}} 
endfunction

function! TelescopeSymbolsCurrentProject() abort
	let symbol = input('rg> ')
	if symbol == ''
		return
	endif

	lua require('telescope.builtin').grep_string{search = symbol,cwd = vim.call('asyncrun#get_root', '%'),search_dirs = {"", "."}} 
endfunction

function! TelescopeLiveGrepCurrentProject() abort
	lua require('telescope.builtin').live_grep{cwd = vim.call('asyncrun#get_root', '%'),search_dirs = {"", "."}} 
endfunction


function! TelescopeRecentFiles()abort
	lua require('telescope.builtin').oldfiles({entry_maker = require('plugins.telescope').entry_gen_from_recentfiles()})
endfunction

function! TelescopeFileBrowser()abort
	lua require('telescope.builtin').file_browser({entry_maker = require('plugins.telescope').entry_gen_from_recentfiles()})
endfunction

function! NvimTreeProjectToggle()abort
	lua require('nvim-tree').toggle({root_dir = vim.call('asyncrun#get_root', '%')})
endfunction


function! TelescopeBuffers()abort
	lua require('telescope.builtin').buffers({entry_maker = require('plugins.telescope').entry_gen_from_buffers()})
endfunction
""""}}}
