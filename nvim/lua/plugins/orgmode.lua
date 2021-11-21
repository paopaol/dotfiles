-- init.lua
require('orgmode').setup({
  org_agenda_files = {'~/workspace/jz/*'},
  org_default_notes_file = '~/workspace/jz/index.org'
})
vim.g.completion_chain_complete_list = {org = {{mode = 'omni'}}}
vim.cmd [[autocmd FileType org setlocal iskeyword+=:,#,+]]
