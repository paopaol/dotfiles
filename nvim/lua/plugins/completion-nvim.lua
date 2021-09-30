vim.g.completion_enable_snippet = 'UltiSnips'
vim.g.completion_enable_auto_signature = 0
vim.g.completion_trigger_on_delete = 1
vim.g.completion_matching_ignore_case = 1
vim.cmd(([[
  autocmd BufEnter * lua require'completion'.on_attach()
  autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']

  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]))
