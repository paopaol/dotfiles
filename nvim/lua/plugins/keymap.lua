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
