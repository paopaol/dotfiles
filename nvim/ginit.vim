if exists('g:GuiLoaded')
	GuiTabline 0
	GuiPopupmenu 0
	call GuiClipboard()
	nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
	vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
endif



