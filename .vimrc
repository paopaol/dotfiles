let $VIMHOME = $HOME . '/.vim'

source $VIMHOME/core/dir.vim


call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'pseewald/vim-anyfold'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/limelight.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'skreek/skeletor.vim'
Plug 'majutsushi/tagbar'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 't9md/vim-choosewin'
Plug 'rakr/vim-one'
Plug 'skywind3000/vim-quickui'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'mhinz/vim-startify'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'
Plug 'lfv89/vim-interestingwords'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'liuchengxu/space-vim-theme'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'liuchengxu/vista.vim'
Plug 'kshenoy/vim-signature'
Plug 'webdevel/tabulous'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'kana/vim-textobj-line'
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'takac/vim-hardtime'
call plug#end()



" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function LspHover() abort
	let f = 'file://' . fnamemodify(expand('%'), ':p')
	let r = line('.') 
	let c = col('.') 
	let resp = CocRequest('ccls', 'textDocument/hover',   {'textDocument': {'uri':f}, 'position': {'line': r - 1, 'character': c - 1}})
	let @* = resp['contents'][0]['value']
endfunction


function JzCocImenu() abort
	let symbols = CocAction('doHover')
	echom symbols
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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


function CreateTerminalTab() abort
	:tabnew
	:terminal ++curwin
	:TabulousRename terminal
endfunction

map <A-Riglt> :tabnext<CR>


source $VIMHOME/core/base_setting.vim

let s:wraped = 0
function ToggleLineWarp() abort
	if s:wraped == 0
		set nowrap
		let s:wraped = 1
	else
		set wrap
		let s:wraped = 0
	endif
endfunction

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

" Mappings using CoCList:
" Show all diagnostics.
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" autocmd Filetype * AnyFoldActivate
" let g:anyfold_fold_comments=1
" set foldlevel=0


""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""" coc snippets
""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'


""quick fix"
nmap <F8> :cn<CR>zz
nmap <S-F8> :cp<CR>zz



" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
	call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	copen
	cc
endfunction

let g:fzf_action = {
			\ 'ctrl-q': function('s:build_quickfix_list'),
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit' }

"""""""""""""""""""""""""""""""""""""""
"""""""""jinzhao""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""
:let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml', '.projectile'] 
:noremap <F5> :AsyncRun -cwd=<root>/build cmake --build <root>/build <cr>
let g:asyncrun_open=10
let g:asyncrun_save=2


let g:choosewin_label_fill = 1
let g:choosewin_keymap   = {}         " initialize as Dictionary
let g:choosewin_keymap.m = 'win_land' " Navigate with 'm'
let g:choosewin_keymap.0 = '<NOP>'    " Disable default 0 keybind
let g:choosewin_overlay_enable = 1
let g:choosewin_label='123456789'
let g:choosewin_tablabel = "ABCDEFGH"

let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = ''
noremap <f3>  <esc>:TagbarToggle<CR>
inoremap <f3>  <esc>:TagbarToggle<CR>
vnoremap <f3>  <esc>:TagbarToggle<CR>

" Select the window where to open the file.
" Use the 'choosewin' plugin if it is loaded.
" Else ask for a user input.
function! DefxSmartL(_)
  if defx#is_directory()
    call defx#call_action('open_or_close_tree')
    normal! j
  else
    let filepath = defx#get_candidate()['action__path']
    if tabpagewinnr(tabpagenr(), '$') >= 3    " if there are more than 2 normal windows
      if exists(':ChooseWin') == 2
        ChooseWin
      else
        let input = input('ChooseWin No./Cancel(n): ')
        if input ==# 'n' | return | endif
        if input == winnr() | return | endif
        exec input . 'wincmd w'
      endif
      exec 'e' filepath
    else
      exec 'wincmd w'
      exec 'e' filepath
    endif
  endif
endfunction

call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('call', 'DefxSmartL')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> <tab>
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  " nnoremap <silent><buffer><expr> C
  " \ defx#do_action('toggle_columns',
  " \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> R
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
endfunction
 
function! Jz_insert_semicolon_end_of_line()
	let save_cursor = getcurpos()
	execute "normal! A;"
	call setpos('.', save_cursor)
endfunction


function! RgProjectFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s %s || true'
	let initial_command = printf(command_fmt, a:query, asyncrun#get_root('%'))
	let reload_command = printf(command_fmt, '{q}', asyncrun#get_root('%'))
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
function! RgProjectAtPointFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s  %s || true'
	let initial_command = printf(command_fmt, a:query, asyncrun#get_root('%'))
	let reload_command = printf(command_fmt, '{q}', asyncrun#get_root('%'))
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RgProject call RgProjectFzf(<q-args>, <bang>0)
command! -bang RgProjectAtPoint call RgProjectAtPointFzf(expand('<cword>'), <bang>0)
command! -bang BLinesAtPoint  call fzf#vim#buffer_lines(expand('<cword>'), <bang>0)

function ProjectFiles() abort
	call fzf#vim#files(asyncrun#get_root('%'))
endfunction

function FilesCurrentDir() abort
	call fzf#vim#files(fnamemodify(expand('%'), ':h'))
endfunction


function ProjectExplorer() abort
	let root = asyncrun#get_root('%')
	execute 'normal! ' . ":Defx -search=" . fnamemodify(expand('%'), ':p') . ' '. root . "\<CR>"
endfunction

nnoremap <silent> <LocalLeader>e
\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
\ :<C-u>Defx -resume  -search=`expand('%:p')`<CR>

function SwitchBetweenHSCpp() 
	let headers = ['h', 'hpp', 'hh']
	let sources = ['c', 'cpp', 'cc']
	let suffix = fnamemodify(expand('%'), ':e')
	let name = fnamemodify(expand('%'), ':t')
	let name = fnamemodify(expand(name), ':r')

	let s:found = []
	for i in headers
		if suffix == i
			let s:found = sources
			break
		endif
	endfor

	for i in sources
		if suffix == i
			let s:found = headers
			break
		endif
	endfor

	let options = ''
	for i in s:found
		let options = options . ' -e ' . i
	endfor
	let cmd = "fd " . name . options . ' ' . asyncrun#get_root('%')
	echom cmd
	call fzf#run({'source': cmd, 'sink': 'e'})
endfunction



noremap <f2><f2> :<C-u>call Jz_insert_semicolon_end_of_line()<CR>
inoremap <f2><f2>   <esc>:<C-u>call Jz_insert_semicolon_end_of_line()<CR>
vnoremap <f2><f2> :call Jz_insert_semicolon_end_of_line()<CR>

""move to end of line"
noremap <C-e> A
inoremap <C-e> <esc>A
vnoremap <C-e> A
"move to begining of line
noremap <C-a> 0i
inoremap <C-a> <esc>0i
vnoremap <C-a> 0i

noremap <C-g> <esc>
inoremap <C-g> <esc>
vnoremap <C-g> <esc>

colorscheme seoul256
let g:solarized_termcolors=256
"背景透明
let g:solarized_termtrans=0
"粗体
let g:solarized_bold=1
"使用下划线
let g:solarized_underline=1
"空白符可见
let g:solarized_hitrail=1

let g:clap_layout = { 'relative': 'editor' }

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:vim_textobj_parameter_mapping = 'a'
let g:rainbow_active = 1 

let g:BufKillCreateMappings = 0
let g:rooter_patterns = ['.projectile', '.git/']
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>

let g:EasyMotion_do_mapping = 0
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
nmap f <Plug>(easymotion-overwin-f)
nmap  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap  n <Plug>(easymotion-next)
nmap  N <Plug>(easymotion-prev)
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

map <C-f> <Right>
imap <C-f> <Right>
map <C-b> <Left>
imap <C-b> <Left>
map <C-k> <Up>
imap <C-k> <Up>
map <C-j> <Down>
imap <C-j> <Down>
let g:hardtime_default_on = 0


let g:which_key_map =  {}
let g:which_local_key_map =  {}
call which_key#register('<Space>', "g:which_key_map")
call which_key#register(',', "g:which_local_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map[' '] = [':ChooseWin', 'choosewin']

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

let g:which_key_map['f'] = {
			\ 'name' : '+files' ,
			\ 'p' : ['ProjectFiles()', 'find file in project'],
			\ 's' : ['w', 'save file'],
			\ 'f' : [':Clap filer', 'find file current dir'],
			\ 'r' : ['History', 'recent files'],
			\ 't' : ['ProjectExplorer()', 'project tree'],
			\ }

let g:which_key_map['b'] = {
			\ 'name' : '+buffer' ,
			\ 'b' : ['fzf#vim#buffers()', 'buffer list'],
			\ 'n' : ['BF', 'next buffer'],
			\ 'p' : ['BB', 'prev buffer'],
			\ 'k' : ['BD', 'buffer kill'],
			\ 'd' : ['BW', 'buffer kill'],
			\ 'q' : ['cclose', 'kill quickfix'],
			\ 'h' : ['Startify', 'home page'],
			\ }

let g:which_key_map['s'] = {
			\ 'name' : '+search & symbol' ,
			\ 's' : ['BLines', 'symbol current buffer'],
			\ 'S' : ['BLinesAtPoint', 'symbol buffer at point'],
			\ 'l' : [':Vista finder', 'tags current buffer '],
			\ 'h' : ['InterestingWords("n")', 'highlight cursor word'],
			\ 'c' : ['UncolorAllWords()', 'unhighlight all words'],
			\ 'p' : ['RgProject', 'rg project'],
			\ 'P' : ['RgProjectAtPoint', 'rg project at point'],
			\ }

let g:which_key_map['t'] = {
			\ 'name' : '+tools/toggle' ,
			\ 'h' : ['Helptags', 'vim help'],
			\ 'r' : ['so ~/.vimrc', 'refresh vimrc'],
			\ 't' : ['Colors', 'theme'],
			\ 'l' : ['ToggleLineWarp()', 'line wrap'],
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
			\ }


let g:which_local_key_map['o'] = {
			\ 'name' : '+c++' ,
			\ 'o' : ['SwitchBetweenHSCpp()', 'cpp/h switch'],
			\}
