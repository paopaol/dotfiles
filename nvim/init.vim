lua require('plugins')
lua require('init')

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

