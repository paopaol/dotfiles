"fzf dir
"author:<tracyone tracyone@live.cn>
"

function! s:start_fzf_dir(timer) abort
	:call dir#FileExploer()
	:redraw!
endfunction

function! s:edit_file(item) abort
	if len(a:item) < 2 | return | endif
	let l:pos = stridx(a:item[1], ' ')
	let l:file_path = a:item[1][pos+1:-1]
	let l:cmd = get({'ctrl-x': 'split',
				\ 'ctrl-v': 'vsplit',
				\ 'ctrl-t': 'tabedit'}, a:item[0], 'e')
	if isdirectory(l:file_path)
		:redraw!
		execute 'cd 'l:file_path
		let l:id = timer_start(20, function('<SID>start_fzf_dir'))
	else
		execute 'silent  '.l:cmd.' ' . l:file_path
	endif
endfunction

function! dir#FileExploer() abort
	let l:run_dict = {
				\ 'source': 'ls -a -F', 
				\ 'sink*': function('<SID>edit_file'),
				\ 'down':'40%' ,
				\ 'options' : ' --ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : '.
				\              '-m --prompt "Find File: "',
				\ }
	:call extend(l:run_dict, {'window': { 'width': 0.6, 'height': 0.4 }})
	call fzf#run(l:run_dict)
endfunction
