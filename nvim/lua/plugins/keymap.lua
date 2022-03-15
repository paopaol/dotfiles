local keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, {noremap = true, silent = true})
end

-- begin of line
keymap('i', '<C-a>', '<Home>')
keymap('c', '<C-a>', '<C-G>U<Home>')

-- end of line
keymap('n', '<C-e>', '<End>a')
keymap('i', '<C-e>', '<End>')
keymap('v', '<C-e>', '<esc><End>a')
keymap('c', '<C-e>', '<End>')

-- backward char
keymap('n', '<C-b>', '<Left>')
keymap('i', '<C-b>', '<Left>')
keymap('v', '<C-b>', '<Left>')
keymap('c', '<C-b>', '<Left>')

-- forward char
keymap('n', '<C-f>', '<Right>')
keymap('i', '<C-f>', '<Right>')
keymap('v', '<C-f>', '<Right>')
keymap('c', '<C-f>', '<Right>')

---next line
keymap('c', '<C-j>', '<Down>')
keymap('i', '<C-j>', '<Down>')
keymap('n', '<C-j>', '5j')

-- previus line
keymap('c', '<C-k>', '<Up>')
keymap('i', '<C-k>', '<Up>')
keymap('n', '<C-k>', '5k')

-- leave insert
keymap('i', '<C-c>', '<esc>')

-- quickfix
keymap('n', 'Q', ':cclose<CR>')
keymap('v', 'Q', ':cclose<CR>')
keymap('n', '<F8>', ':cn<CR>zz')
keymap('n', '<F7>', ':cp<CR>zz')

-- window navigate
keymap('', '<A-j>', '<C-W>j')
keymap('', '<A-k>', '<C-W>k')
keymap('', '<A-h>', '<C-W>h')
keymap('', '<A-l>', '<C-W>l')
keymap('n', '<A-->', ':resize -1<CR>')
keymap('n', '<A-=>', ':resize +1<CR>')

keymap('n', '<A-<>', ':SidewaysLeft<CR>')
keymap('n', '<A->>', ':SidewaysRight<CR>')

-- remap << >>
keymap('x', '>', '>gv')
keymap('x', '<', '<gv')

-- terminal
keymap('t', '<esc>', '<C-\\><C-n>')
