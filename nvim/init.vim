
let $VIMHOME = fnamemodify(expand('<sfile>'), ':p')
let $VIMHOME = resolve($VIMHOME)
let $VIMHOME =  fnamemodify(expand($VIMHOME), ':p:h')
source $VIMHOME/core/base_setting.vim


"plug -----{{{
augroup plgu
	call plug#begin('~/.vim/plugged')
	Plug 'bagrat/vim-buffet'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'mhinz/vim-grepper'
	Plug 'paopaol/vim-terminal-help'
	Plug 'flazz/vim-colorschemes'
	Plug 'sbdchd/neoformat'
	Plug 'vim-scripts/DoxygenToolkit.vim'
	Plug 'plasticboy/vim-markdown'
	Plug 'terryma/vim-expand-region'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'cormacrelf/vim-colors-github'
	Plug 'easymotion/vim-easymotion'
	Plug 'haya14busa/incsearch.vim'
	Plug 'haya14busa/incsearch-easymotion.vim'
	Plug 'haya14busa/incsearch-fuzzy.vim'
	Plug 'glepnir/spaceline.vim'
	Plug 'ryanoasis/vim-devicons'
	" Plug 'pacha/vem-tabline'
	Plug 'Raimondi/delimitMate'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'junegunn/seoul256.vim'
	Plug 'pseewald/vim-anyfold'
	Plug 'junegunn/goyo.vim'
	Plug 'mattn/emmet-vim'
	Plug 'justinmk/vim-sneak'
	Plug 'junegunn/limelight.vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'honza/vim-snippets'
	Plug 'skreek/skeletor.vim'
	Plug 'skywind3000/asynctasks.vim'
	Plug 'skywind3000/asyncrun.vim'
	" Plug 'vim-airline/vim-airline-themes'
	" Plug 'bling/vim-airline'
	Plug 'tpope/vim-surround'
	Plug 't9md/vim-choosewin'
	Plug 'rakr/vim-one'
	Plug 'mhinz/vim-startify'
	Plug 'rbgrouleff/bclose.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'liuchengxu/vim-which-key'
	Plug 'lfv89/vim-interestingwords'
	Plug 'liuchengxu/space-vim-theme'
	Plug 'tomasr/molokai'
	Plug 'kana/vim-textobj-user'
	Plug 'sgur/vim-textobj-parameter'
	Plug 'rhysd/vim-textobj-anyblock'
	Plug 'luochen1990/rainbow'
	Plug 'tpope/vim-commentary'
	Plug 'thinca/vim-qfreplace'
	Plug 'markonm/traces.vim'
	Plug 'othree/html5.vim'
	Plug 'mklabs/vim-json'
	Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
	Plug 'kshenoy/vim-signature'
	Plug 'kana/vim-textobj-line'
	Plug 'cespare/vim-toml'
	call plug#end()
augroup END
"}}}

let g:spaceline_seperate_style = 'arrow'
let g:spaceline_custom_buffer_number = ['0','1', '2', '3','4', '5', '6', '7', '8']

"startify{{{
augroup startify
	autocmd!
	let g:startify_custom_header =startify#center([
				\"███████╗ ███╗   ███╗  █████╗   ██████╗ ███████╗",
				\"██╔════╝ ████╗ ████║ ██╔══██╗ ██╔════╝ ██╔════╝",
				\"█████╗   ██╔████╔██║ ███████║ ██║      ███████╗",
				\"██╔══╝   ██║╚██╔╝██║ ██╔══██║ ██║      ╚════██║",
				\"███████╗ ██║ ╚═╝ ██║ ██║  ██║ ╚██████╗ ███████║",
				\"╚══════╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝  ╚═════╝ ╚══════╝",
				\])
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

"vimscript file settings ---------------------{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"markdown {{{
augroup filetype_markdown
	autocmd!
	let g:vim_markdown_folding_disabled = 1
augroup END
" }}}

"xml_html filetype_xml {{{
augroup filetype_xml
	autocmd!
  autocmd FileType xml    	set tabstop=2
augroup END
"}}}


"leaderf settings-------------------{{{
augroup leaderf
	autocmd!


	function ProjectFiles() abort
		let root = asyncrun#get_root('%')
		execute ':Leaderf file ' . root . "\<CR>"
	endfunction

	function ProjectFilesCurrentdir() abort
		let root = fnamemodify(expand('%'), ':p:h')
		execute ':Leaderf file ' . root . "\<CR>"
	endfunction

	let g:Lf_RootMarkers = ['.projectile']
	let g:Lf_ShortcutF=''
	let g:Lf_ShortcutB=''
	let g:Lf_ShowRelativePath = 0
	let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
	let g:Lf_ShowDevIcons = 0
augroup END
"  }}}

"commentary------------------{{{
augroup commentary
	autocmd!

	autocmd FileType cpp setlocal commentstring=//\ %s
augroup END
"}}}

"tabline{{{
" augroup tabline
" 	autocmd!
" 	let g:vem_tabline_show_number = 'index'
" augroup END
"}}}
"vim-buffet{{{
augroup vim_buffet
	autocmd!
	let g:buffet_powerline_separators = 1
	let g:buffet_show_index = 1
	let g:buffet_tab_icon = '✓'
augroup END
"}}}

""airline ----{{{
"" augroup airline
"	" autocmd!
"
"	function! AirlineInit()
"		let g:airline_section_a = airline#section#create_left(['%{winnr()}'])
"		" let g:airline_section_a = airline#section#create_left(['%{winnr()}', 'crypt'])
"		" let g:airline_section_c = airline#section#create_left(['%{ProjectRelativeFilePath()}'])
"	endfunction
"	let g:airline_theme = "dark"
"	" let g:airline#extensions#tabline#enabled = 1
"	let g:airline_highlighting_cache = 1
"	let g:airline_focuslost_inactive = 0
"	" let g:airline_inactive_collapse=0
"	let g:airline#extensions#whitespace#enabled = 0
"	let g:airline#extensions#whitespace#symbol = '!'
"	let g:airline#extensions#tabline#formatter = 'unique_tail'
"	let g:airline#extensions#tabline#fnamemod = ':p:.'
"	let g:airline#extensions#tabline#fnametruncate = 1
"	autocmd User AirlineAfterInit call AirlineInit()
"" augroup END
""}}}

"coc--------------{{{
augroup coc
	autocmd!
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction


	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	function ProjectExplorerCurrent() abort
		let root = fnamemodify(expand('%'), ':p:h')
		execute 'normal! ' . ":CocCommand explorer  --sources=file+ --floating-position center  --position floating  " . root . "\<CR>"
	endfunction


	function ProjectExplorer() abort
		let root = asyncrun#get_root('%')
		execute 'normal! ' . ":CocCommand explorer   --position=left --sources=file+  " . root . "\<CR>"
	endfunction

	function OpenFileInExplorer() abort
		if has('win32')
			execute 'normal! ' . ":!explorer /select," . fnamemodify(expand('%'), ':p') . "\<CR>"
		endif
	endfunction

	" URL encode a string. ie. Percent-encode characters as necessary.
	function! UrlEncode(string)

		let result = ""

		let characters = split(a:string, '.\zs')
		for character in characters
			if character == " "
				let result = result . "+"
			elseif CharacterRequiresUrlEncoding(character)
				let i = 0
				while i < strlen(character)
					let byte = strpart(character, i, 1)
					let decimal = char2nr(byte)
					let result = result . "%" . printf("%02x", decimal)
					let i += 1
				endwhile
			else
				let result = result . character
			endif
		endfor

		return result

	endfunction

	" Returns 1 if the given character should be percent-encoded in a URL encoded
	" string.
	function! CharacterRequiresUrlEncoding(character)

		let ascii_code = char2nr(a:character)
		if ascii_code >= 48 && ascii_code <= 57
			return 0
		elseif ascii_code >= 65 && ascii_code <= 90
			return 0
		elseif ascii_code >= 97 && ascii_code <= 122
			return 0
		elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
			return 0
		endif

		return 1

	endfunction

	function LspHover() abort
		if has('win32')
			let f = 'file:///' . UrlEncode(fnamemodify(expand('%'), ':p'))
		else
			let f = 'file://' . UrlEncode(fnamemodify(expand('%'), ':p'))
		endif
		let r = line('.')
		let c = col('.')
		let resp = CocRequest('ccls', 'textDocument/hover',   {'textDocument': {'uri':f}, 'position': {'line': r - 1, 'character': c - 1}})
		let @* = resp['contents'][0]['value']
		echom @*
	endfunction

	"""""coc-explorer
	let g:coc_explorer_global_presets = {
				\   'floating': {
				\      'position': 'left',
				\   },
				\   'floatingLeftside': {
				\      'position': 'left',
				\      'floating-position': 'left-center',
				\      'floating-width': 50,
				\   },
				\   'floatingRightside': {
				\      'position': 'right',
				\      'floating-position': 'left-center',
				\      'floating-width': 50,
				\   },
				\   'simplify': {
				\     'file.child.template': '[filename growRight 1]',
				\     'file.child.labeling.template':'', 
				\   }
				\ }


	""""""""""""""""""""""""""""""""
	"""""""""""""""""""""""""""""""" coc snippets
	""""""""""""""""""""""""""""""""
	""""""""""""""""""""""""""""""""
        inoremap <silent><expr> <TAB>
				\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : <SID>check_back_space() ? "\<TAB>" :  coc#refresh()


	let g:coc_snippet_next = '<tab>'
	let g:coc_snippet_prev = '<S-tab>'




	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	if has('patch8.1.1068')
		" Use `complete_info` if your (Neo)Vim version supports it.
		imap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	inoremap <expr> <C-j> pumvisible() ? '<C-n>' :'<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
	inoremap <expr> <C-k> pumvisible() ? '<C-p>' :'<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'
	

	" Highlight the symbol and its references when holding the cursor.
	" autocmd CursorHold * silent call CocActionAsync('highlight')

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end


	command! -nargs=0 Format :call CocAction('format')
	let g:coc_global_extensions = ['coc-bookmark', 'coc-cmake', 'coc-css', 
				\ 'coc-emmet', 'coc-fs-lists', 'coc-html', 'coc-json',
				\ 'coc-snippets','coc-tasks', 'coc-translator', 'coc-rust-analyzer',
				\'coc-tsserver', 'coc-vimlsp', 'coc-prettier', 'coc-yaml', 'coc-word', 'coc-translator']
	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> <C-]> <Plug>(coc-definition)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	" Remap keys for applying codeAction to the current line.
	nnoremap gi  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nnoremap gf  <Plug>(coc-fix-current)
	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)
	vmap <f9> <Plug>(coc-translator-pv)

	noremap <silent> <f12> :<C-u>call ProjectExplorer()<CR>
augroup END
"}}}

"greper-----------{{{
augroup grepper
	autocmd!
	function GrepperProjectSymbolAtPoint() abort
		execute ':Grepper -dir repo -cword -noprompt '
	endfunction

	function GrepperCurrentDirectorySymbolAtPoint() abort
		execute ':Grepper -dir cwd -cword -noprompt '
	endfunction

	function GrepperProjectSymbol()abort
		execute ':Grepper -dir repo'
	endfunction

	function GrepperCurrentBufferAtPoint() abort
		execute ':Grepper -buffer -cword -noprompt'
	endfunction

	function GrepperCurrentBuffer() abort
		execute ':Grepper -buffer'
	endfunction


	let g:grepper = {}            " initialize g:grepper with empty dictionary
	runtime plugin/grepper.vim    " initialize g:grepper with default values
	let g:grepper.tools = ['rg']
	" let g:grepper.rg = {}
	" let g:grepper.rg.grepprg = ''
	" let g:grepper.rg = { 'grepprg':'rg -H --no-heading --vimgrep' }
	" let g:grepper.rg.grepprg .= ' --smart-case'
	let g:grepper.repo = ['.projectile']
	let g:grepper.highlight = 1
	let g:grepper.prompt = 1
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

	let g:terminal_key='<f11>'
	if has('win32')
		let g:terminal_shell='powershell.exe'
	endif
augroup END
"}}}

"""window settings---------{{{
augroup window
	autocmd!

	colorscheme whitebox

	map <A-j> <C-W>j
	map <A-k> <C-W>k
	map <A-h> <C-W>h
	map <A-l> <C-W>l

	nnoremap Q :cclose<CR>
	vnoremap Q :cclose<CR>

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


	""quick fix"
	nnoremap <F8> :cn<CR>zz
	nnoremap <F7> :cp<CR>zz

	""window resie
	nnoremap <A--> :resize -1<CR>
	nnoremap <A-=> :resize +1<CR>
	nnoremap <A-<> <C-W><
	nnoremap <A->> >C-W>>
augroup END
"}}}

"asyncrun"""""""""""""""""""""""""""""{{{
augroup asyncrun
	autocmd!

	if has('win32')
		let g:asyncrun_encs = 'gbk'
	endif
	let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', '.projectile']
	noremap <F5> :AsyncRun -cwd=<root>/build cmake --build <root>/build <cr>
	let g:asyncrun_open=6
	let g:asyncrun_save=2
augroup END
"}}}

"choosewin""""""""""""""""""""""{{{
augroup choosewin
	autocmd!
	let g:choosewin_label_fill = 1
	let g:choosewin_keymap   = {}         " initialize as Dictionary
	let g:choosewin_keymap.m = 'win_land' " Navigate with 'm'
	let g:choosewin_keymap.0 = '<NOP>'    " Disable default 0 keybind
	let g:choosewin_overlay_enable = 1
	let g:choosewin_label='123456789'
	let g:choosewin_tablabel = "ABCDEFGH"
augroup END
"}}}


"vim settings -----------------{{{
augroup vimsettings
	autocmd!
	function! ImSelectEn()
		if has('win32')
			call system('im-select 1033')
		else
			call system('ibus engine xkb:us::eng')
		endif
	endfunction

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

	autocmd InsertLeave * call ImSelectEn()

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
	nnoremap <f2><f2> :<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	inoremap <f2><f2>   <C-o>:<C-u>call Jz_insert_semicolon_end_of_line()<CR>
	vnoremap <f2><f2> :call Jz_insert_semicolon_end_of_line()<CR>
	" select block
	" vnoremap v a}o0
	tnoremap <Esc> <C-\><C-n>
	au FocusGained * :checktime
augroup END
"}}}

inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    if pumvisible()
        return "\<C-y>"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction







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

function LspFormat() abort
	if &ft == 'cpp'
		execute ':Neoformat'
	elseif &ft == 'cmake'
		call CmakeFormatCurrentFile()
	else
		execute ':Format'
	endif
	call SaveBuf()
endfunction





let g:vim_textobj_parameter_mapping = 'a'
let g:rainbow_active = 1

let g:BufKillCreateMappings = 0
let g:rooter_patterns = ['.projectile', '.git/']
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>


"sneak{{{
augroup sneak
	autocmd!

	let g:sneak#s_next = 1
	nmap s <Plug>Sneak_s
	nmap S <Plug>Sneak_S
	nmap f <Plug>Sneak_f
	nmap F <Plug>Sneak_F
	nmap t <Plug>Sneak_t
	nmap T <Plug>Sneak_T
augroup END
"}}}





"""which_key -----------------{{{
augroup which_key
	autocmd!

	function! Uncolor_all_words() abort
		call UncolorAllWords()
		set nohlsearch
	endfunction

	autocmd! FileType which_key
	autocmd  FileType which_key set laststatus=0 noshowmode noruler
				\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler




	let g:which_key_use_floating_win = 0
	let g:mapleader = "\<Space>"
	let g:maplocalleader = ','
	let g:which_key_map =  {}
	call which_key#register('<Space>', "g:which_key_map")
	let g:local_key_map =  {}
	nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
	nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

	let g:which_key_map['q'] = [':wq!', 'quit']
	let g:which_key_map[' '] = [':ChooseWin', 'choosewin']
	let g:which_key_map['1'] = ['<Plug>BuffetSwitch(1)', 'tab 1']
	let g:which_key_map['2'] = ['<Plug>BuffetSwitch(2)', 'tab 2']
	let g:which_key_map['3'] = ['<Plug>BuffetSwitch(3)', 'tab 3']
	let g:which_key_map['4'] = ['<Plug>BuffetSwitch(4)', 'tab 4']
	let g:which_key_map['5'] = ['<Plug>BuffetSwitch(5)', 'tab 5']
	let g:which_key_map['6'] = ['<Plug>BuffetSwitch(6)', 'tab 6']
	let g:which_key_map['7'] = ['<Plug>BuffetSwitch(7)', 'tab 7']
	let g:which_key_map['8'] = ['<Plug>BuffetSwitch(8)', 'tab 8']
	let g:which_key_map['9'] = ['<Plug>BuffetSwitch(9)', 'tab 9']
	let g:which_key_map['w'] = {
				\ 'name' : '+windows' ,
				\ 'w' : ['<C-W>w'     , 'other-window'         ],
				\ '1' : ['only'       , 'close other window'   ],
				\ 'd' : ['<C-W>c'     , 'delete-window'        ],
				\ '=' : ['<C-W>='     , 'balance-window'       ],
				\ 'm' : ['<C-W>|'     , 'max-window'           ],
				\ 's' : ['<C-W>s'     , 'split-window-below'   ],
				\ 'v' : ['<C-W>v'     , 'split-window-below'   ],
				\ 'q' : ['qa'         , 'quit vim'             ],
				\ }
	let g:which_key_map['c'] = {
				\ 'name' : '+coc' ,
				\ }

	let g:which_key_map['c']['b'] = {
				\ 'name' : '+bookmark' ,
				\ 'a' : [':CocCommand bookmark.annotate'   , 'bookmark annotation'  ],
				\ 't' : [':CocCommand bookmark.toggle'     , 'bookmark annotation'  ],
				\ 'l' : [':CocList --normal bookmark'      , 'bookmark annotation'  ],
				\ }

	let g:which_key_map['f'] = {
				\ 'name' : '+files' ,
				\ 'p' : ['ProjectFiles()', 'find file in project'],
				\ 'd' : ['ProjectFilesCurrentdir()', 'find file in current'],
				\ 's' : ['w', 'save file'],
				\ 'o' : ['OpenFileInExplorer()', 'find file current dir'],
				\ 'r' : [':Leaderf mru', 'recent files'],
				\ 't' : ['ProjectExplorer()', 'project tree'],
				\ }

	let g:which_key_map['b'] = {
				\ 'name' : '+buffer' ,
				\ 'b' : ['LeaderfBuffer', 'buffer list'],
				\ 'n' : ['bn', 'next buffer'],
				\ 'p' : ['bp', 'prev buffer'],
				\ 'k' : ['Bclose', 'buffer kill'],
				\ 'd' : ['BW', 'buffer kill'],
				\ 'q' : ['cclose', 'kill quickfix'],
				\ 'h' : ['Startify', 'home page'],
				\ }

	let g:which_key_map['s'] = {
				\ 'name' : '+search & symbol' ,
				\ 's' : [':Leaderf line --regexMode', 'symbol current buffer'],
				\ 'S' : ['GrepperCurrentBufferAtPoint()', 'symbol buffer at point'],
				\ 'l' : [':Leaderf function', 'tags current buffer '],
				\ 'h' : ['InterestingWords("n")', 'highlight cursor word'],
				\ 'c' : ['Uncolor_all_words()', 'unhighlight all words'],
				\ 'p' : ['GrepperProjectSymbol()', 'rg project'],
				\ 't' : [':CocList tasks ', 'async tasks'],
				\ 'P' : ['GrepperProjectSymbolAtPoint()', 'rg project at point'],
				\ }
	let g:which_key_map['s']['g'] = {
				\ 'name' : '+google' ,
				\ 't' : ['<Plug>(coc-translator-pv)', 'trans->zh'],
				\}

	let g:which_key_map['t'] = {
				\ 'name' : '+tools/toggle' ,
				\ 'h' : [':Leaderf help', 'vim help'],
				\ 'r' : [':so ~/.vimrc', 'refresh vimrc'],
				\ 'c' : ['LeaderfColorscheme', 'theme'],
				\ 'l' : [':setlocal wrap!', 'line wrap'],
				\ }

	let g:which_key_map['l'] = {
				\ 'name' : '+lsp' ,
				\ 'f' : ['Format', 'format'],
				\ 'r' : ['<Plug>(coc-rename)', 'rename'],
				\ 'a' : [':CocList diagnostics', 'diagnostics'],
				\ 'y' : ['LspHover()', 'LspHover yank'],
				\ }

	let g:which_key_map['l']['e'] = {
				\ 'name' : '+error' ,
				\ 'n' : ['<Plug>(coc-diagnostic-next)', 'next error'],
				\ 'p' : ['<Plug>(coc-diagnostic-prev)', 'prev error'],
				\ }

	let g:which_key_map['g'] = {
				\ 'name' : '+git' ,
				\ 's' : ['Gstatus', 'git status'],
				\ 'b' : ['Gblame', 'git blame'],
				\ 'l' : ['Glog', 'git log'],
				\ 'p' : ['Gpush', 'git push'],
				\ }

	augroup flletype_startify
		autocmd!
		autocmd  FileType startify let g:local_key_map['startify'] =  {}
		autocmd  FileType startify let g:local_key_map['startify']['q'] = [':q', 'quit']
	augroup end
	augroup flletype_cpp
		autocmd!
		autocmd  FileType cpp    let g:local_key_map['cpp'] =  {}
		autocmd  FileType cpp    let g:local_key_map['cpp'][','] = ['LspFormat()', 'lsp format']
		autocmd  FileType cpp    let g:local_key_map['cpp']['d'] = ['Dox', 'DoxygenToolkit']
		autocmd  FileType cpp    let g:local_key_map['cpp']['y'] = ['LspHover()', 'lsp hover']
	augroup end
	augroup flletype_c
		autocmd!
		autocmd  FileType c    let g:local_key_map['c'] =  {}
		autocmd  FileType c    let g:local_key_map['c'][','] = ['LspFormat()', 'lsp format']
		autocmd  FileType c    let g:local_key_map['c']['d'] = ['Dox', 'DoxygenToolkit']
		autocmd  FileType c    let g:local_key_map['c']['y'] = ['LspHover()', 'lsp hover']
	augroup end
	augroup flletype_json
		autocmd!
		autocmd  FileType json  let g:local_key_map['json'] =  {}
		autocmd  FileType json  let g:local_key_map['json'][','] = ['LspFormat()', 'lsp format']
	augroup end
	augroup flletype_vim
		autocmd!
		autocmd  FileType vim  let g:local_key_map['vim'] =  {}
		autocmd  FileType vim  let g:local_key_map['vim'][','] = ['LspFormat()', 'lsp format']
	augroup end
	augroup flletype_rust
		autocmd!
		autocmd  FileType rust  let g:local_key_map['rust'] =  {}
		autocmd  FileType rust  let g:local_key_map['rust'][','] = ['LspFormat()', 'lsp format']
		autocmd  FileType rust  let g:local_key_map['rust']['r'] = ['RustRun', 'run']
	augroup end
	augroup flletype_cmake
		autocmd!
		autocmd  FileType cmake  let g:local_key_map['cmake'] =  {}
		autocmd  FileType cmake  let g:local_key_map['cmake'][','] = ['LspFormat()', 'lsp format']
	augroup end
	augroup flletype_yaml
		autocmd!
		autocmd  FileType yaml  let g:local_key_map['yaml'] =  {}
		autocmd  FileType yaml  let g:local_key_map['yaml'][','] = ['LspFormat()', 'lsp format']
	augroup end
	augroup flletype_markdown
		autocmd!
		autocmd  FileType markdown    let g:local_key_map['markdown'] =  {}
		autocmd  FileType markdown    let g:local_key_map['markdown'][','] = ['LspFormat()', 'lsp format']
		autocmd  FileType markdown    let g:local_key_map['markdown']['p'] = {'name':"+preview"}
		autocmd  FileType markdown    let g:local_key_map['markdown']['p']['p'] = [':MarkdownPreview', 'markdown preview']
		autocmd  FileType markdown    let g:local_key_map['markdown']['p']['t'] = [':Tocv', 'markdown preview toc vsplit']
		autocmd  FileType markdown    let g:local_key_map['markdown']['i'] = {'name':'+insert'}
		autocmd  FileType markdown    let g:local_key_map['markdown']['i']['t'] = [':InsertToc', 'insert toc']
	augroup end


	augroup flletype_localleader_key
		autocmd!

		function! s:register_localleader_ley_map_of_which_key() abort
			if &ft != 'which_key' && has_key(g:local_key_map, &ft)
				call which_key#register(',', g:local_key_map[&ft])
			else
				call which_key#register(',', {})
			endif
		endfunction

		autocmd  BufEnter *  call s:register_localleader_ley_map_of_which_key()
	augroup END

augroup END
"}}}
