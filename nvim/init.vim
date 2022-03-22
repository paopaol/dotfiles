
let $VIMHOME = fnamemodify(expand('<sfile>'), ':p')
let $VIMHOME = resolve($VIMHOME)
let $VIMHOME =  fnamemodify(expand($VIMHOME), ':p:h')


"plug -----{{{
augroup plug
	call plug#begin('~/.vim/plugged')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'mbbill/fencview'
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug '/home/jz/.vim/plugged/recentfiles.nvim'
	Plug '/home/jz/.vim/plugged/fzf-vim-bookmarks.nvim'
	Plug '/home/jz/.vim/plugged/fzf-files-explorer.nvim'
	Plug 'ton/vim-bufsurf'
	Plug 'mfussenegger/nvim-dap'
	Plug 'Pocco81/DAPInstall.nvim',{'branch':'main'}
	Plug 'akinsho/toggleterm.nvim'
	Plug 'chiel92/vim-autoformat'
	Plug 'paopaol/telescope-ctags.nvim'
	Plug 'paopaol/telescope-vimsnip.nvim' , {'branch': 'main'}
	Plug 'paopaol/cpp-mode' , {'branch': 'main'}
	Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'akinsho/nvim-bufferline.lua'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', {'branch': 'master'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
	Plug 'folke/which-key.nvim', {'branch':'main'}
	Plug 'neovim/nvim-lspconfig'
	Plug 'kabouzeid/nvim-lspinstall', {'branch':'main'}
	Plug 'windwp/nvim-autopairs'
	Plug 'vimwiki/vimwiki'
	Plug 'MattesGroeger/vim-bookmarks'
	Plug 'vim-scripts/bufkill.vim'
	Plug 'crispgm/telescope-heading.nvim', {'branch':'main'}
	Plug 'voldikss/vim-floaterm'
	Plug 'karb94/neoscroll.nvim'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'mhartington/formatter.nvim'
	Plug 'onsails/lspkind-nvim'
	Plug 'voldikss/vim-translator'
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'glepnir/dashboard-nvim'
	" Plug 'TimUntersberger/neogit'
	" Plug 'f-person/git-blame.nvim'
	Plug 'kazhala/close-buffers.nvim'
	Plug 'paopaol/fzf-lua', {'branch': 'main'}
	Plug 'vijaymarupudi/nvim-fzf'
	Plug 'weilbith/nvim-floating-tag-preview'
	Plug 'paopaol/fzf-snippet.nvim' , {'branch': 'main'}
	Plug 'paopaol/fzf-asynctask.nvim', {'branch': 'main'}
	Plug 'romgrk/nvim-treesitter-context'
	Plug 'preservim/nerdtree'
	Plug 't9md/vim-choosewin'
	Plug 'weilbith/nerdtree_choosewin-plugin'
	Plug 'folke/todo-comments.nvim' , {'branch': 'main'}
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug '907th/vim-auto-save'
	Plug 'nvim-neorg/neorg', {'branch':'unstable'}

	Plug 'kristijanhusak/orgmode.nvim'
	Plug 'chentau/marks.nvim'


	Plug 'lilydjwg/fcitx.vim', {'branch' : 'fcitx5'}
	"""colors
	Plug 'mhartington/oceanic-next'
	Plug 'Mofiqul/vscode.nvim', {'branch': 'main'}
	Plug 'marko-cerovac/material.nvim', {'branch':'main'}
	Plug 'keyvchan/monokai.nvim'
	Plug 'rktjmp/lush.nvim', {'branch':'main'}
	Plug 'npxbr/gruvbox.nvim', {'branch':'main'}
	Plug 'EdenEast/nightfox.nvim', {'branch':'main'}
	Plug 'folke/tokyonight.nvim', {'branch':'main'}
	Plug 'ishan9299/nvim-solarized-lua'
	Plug 'rafamadriz/neon', {'branch':'main'}
	Plug 'bluz71/vim-nightfly-guicolors'
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'sainnhe/sonokai'
	Plug 'lourenci/github-colors', {'branch':'main'}
	Plug 'ayu-theme/ayu-vim', {'branch':'main'}
	"""

	Plug 'skanehira/preview-markdown.vim'
	Plug 'rhysd/accelerated-jk'
	Plug 'mhinz/vim-grepper'
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
	Plug 'skywind3000/asynctasks.vim' 
	Plug 'skywind3000/asyncrun.vim' 
	Plug 'tpope/vim-surround' 
	Plug 'rakr/vim-one' 
	Plug 'tpope/vim-fugitive'
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
	Plug 'matveyt/vim-qmake'

	Plug 'hrsh7th/cmp-nvim-lsp' , {'branch':'main'}
	Plug 'hrsh7th/cmp-path', {'branch':'main'}
	Plug 'hrsh7th/nvim-cmp', {'branch':'main'}
	Plug 'hrsh7th/cmp-buffer', {'branch':'main'} 
	Plug 'quangnguyen30192/cmp-nvim-ultisnips' , {'branch':'main'}
	call plug#end()
augroup END
"}}}



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


"commentary------------------{{{
augroup commentary
	autocmd!

	autocmd FileType cpp setlocal commentstring=//\ %s
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


"""window settings---------{{{
augroup window
	autocmd!

	" set termguicolors     " enable true colors support
	let g:material_style = 'lighter'
	let ayucolor="light"  " for light version of theme
	" let ayucolor="mirage" " for mirage version of theme
	" let ayucolor="dark"   " for dark version of theme
	let g:github_comment_style = "italic"
	let g:github_keyword_style = "italic"
	let g:github_function_style = "italic"
	let g:github_variable_style = "italic"
	" colorscheme gruvbox


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


	" nnoremap <silent> <tab> :call JumpRight()<CR>
	" nnoremap <silent> <S-tab> :SidewaysJumpRight<CR>
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

lua << EOF
require('plugins.setup')
require('plugins.keymap')
EOF
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

	filetype plugin on
	syntax on

	" set shortmess+=c
	" set clipboard+=unnamedplus
	if has("autocmd")
		au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	endif
	""""""""'

	autocmd InsertLeave * call ImSelectEn()


	if has('nvim')
	else
		if has('win32')
			" set pythonthreedll=python38.dll
		else
			set pyxversion=3
		endif
	endif
	nnoremap <F2><F2> :<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	inoremap <F2><F2>   <C-o>:<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	vnoremap <F2><F2> :call Jz_insert_semicolon_end_of_line()<CR>
	" select block
	" vnoremap v a}o0
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



call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-j>',
      \ 'previous_key': '<C-k>',
      \ 'accept_key': '<Tab>',
      \ 'reject_key': '<C-c>',
      \ })



call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['fd', '-tf'],
      \       'dir_command': ['fd', '-tf'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#vim_fuzzy_filter(),
      \     }),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ }))

lua << EOF
require('plugins.accelerated')
require('plugins.lsp')
require('plugins.lspsaga')
require('plugins.status-line')
require('plugins.telescope')
require('plugins.which-key')
require('plugins.autopairs')
require('plugins.formatter')
require('plugins.lspkind')
require'telescope'.load_extension('ctags')
require('plugins.dashboard-nvim')
--require('neogit').setup{}
require('plugins.fzf')
require('plugins.neoscroll')
require('plugins.vimspector')
require('nvim-autopairs')
require('plugins.ultisnips')
require('plugins.nvim-cmp')
require('plugins.todo')
require('plugins.toggle_term')
require('plugins.marks')
require('plugins.jz')
--require "lsp_signature".setup({hint_prefix = "  "})
require('plugins.rainbow')
require('plugins.nvim-treesitter')
--require('plugins.indent')
require('plugins.bufferline')
require'treesitter-context'.setup{ enable = true, throttle = true }
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}
require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        my_workspace = "~/workspace/jz/note"
                    }
                }
            }
        },
    }
EOF

augroup nerdtree
let g:NERDTreeMapActivateNode = '<cr>'
let NERDTreeIgnore=['\.d$[[dir]]', '\.o$[[file]]', 'tmp/cache$[[path]]', 'moc_*', 'Makefile']
autocmd FileType NERDTREE set buflisted
autocmd FileType tar set buflisted
augroup END


augroup bookmark
	autocmd!
	let g:bookmark_no_default_key_mappings=1
augroup END


let g:fcitx5_remote='fcitx-remote'

let g:translator_default_engines = ['google']
let g:translator_window_type = 'popup'
