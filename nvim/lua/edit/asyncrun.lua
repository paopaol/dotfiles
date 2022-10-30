vim.cmd([[
  if has('win32')
    let g:asyncrun_encs = 'gbk'
  endif
]])

vim.g.asyncrun_rootmarks = {
  '.git', '.root', '.bzr', '_darcs', 'build.xml', '.projectile'
}
vim.g.asyncrun_open = 15
vim.g.asyncrun_save = 2
