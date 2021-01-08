if exists('g:GuiLoaded')
	GuiTabline 0
	GuiPopupmenu 0
	GuiFont! FiraCode Nerd Font Mono:h11
	call GuiClipboard()
	nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
	inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
	vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
endif
