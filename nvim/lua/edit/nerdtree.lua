vim.g.NERDTreeMapActivateNode = '<cr>'
vim.g.NERDTreeIgnore = {
  ".d$[[dir]]", '.o$[[file]]', 'tmp/cache$[[path]]', 'moc_*', 'Makefile'
}


vim.cmd([[
augroup nder
  autocmd!
  autocmd FileType NERDTREE set buflisted
  autocmd FileType tar set buflisted
augroup END
]])
