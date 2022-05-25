local keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end
local unsilent_keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = false })
end

-- begin of line
keymap('i', '<C-a>', '<Home>')
unsilent_keymap('c', '<C-a>', '<Home>')

-- end of line
keymap('n', '<C-e>', '<End>a')
keymap('i', '<C-e>', '<End>')
keymap('v', '<C-e>', '<esc><End>a')
unsilent_keymap('c', '<C-e>', '<End>')

-- backward char
keymap('n', '<C-b>', '<Left>')
keymap('i', '<C-b>', '<Left>')
keymap('v', '<C-b>', '<Left>')
unsilent_keymap('c', '<C-b>', '<Left>')
keymap('i', '<A-b>', '<C-Left>')

-- forward char
keymap('n', '<C-f>', '<Right>')
keymap('i', '<C-f>', '<Right>')
keymap('v', '<C-f>', '<Right>')
unsilent_keymap('c', '<C-f>', '<Right>')
keymap('i', '<A-f>', '<C-Right>')

---next line
unsilent_keymap('c', '<C-j>', '<Down>')
keymap('i', '<C-j>', '<Down>')
keymap('n', '<C-j>', '5j')

-- previus line
unsilent_keymap('c', '<C-k>', '<Up>')
keymap('i', '<C-k>', '<Up>')
keymap('n', '<C-k>', '5k')

-- leave insert
keymap('i', '<C-c>', '<esc>');
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

-- virual mode,which-key works bad
keymap('v', ',!', ':!bash<cr>')
keymap('v', ',tt', ':Translate<cr>')
keymap('v', ',,', ':lua vim.lsp.buf.range_formatting()<cr>')

---move line down or up
keymap('n', '<A-Down>', ":MoveLine(1)<CR>")
keymap('n', '<A-Up>', ":MoveLine(-1)<CR>")
keymap('v', '<A-Down>', ":MoveBlock(1)<CR>")
keymap('v', '<A-Up>', ":MoveBlock(-1)<CR>")

keymap('n', 'n', ":Interestingwords --navigate<cr>")
keymap('n', 'N', ":Interestingwords --navigate b<cr>")



keymap('v', 'gy', ":lua ___gdc('v')<cr>")

local format_json_region = function(opts)
  local cmd = string.format("silent  %d,%d !prettier.cmd --stdin-filepath=1.json", opts.line1, opts.line2)
  vim.cmd(cmd)
end

vim.api.nvim_create_user_command("JsonFormatRegion", format_json_region, { range = 2 })

vim.api.nvim_create_user_command("LineDiagnostic",
  function()
    local opts = {
      focusable = true,
      border = 'rounded',
      prefix = '',
    }
    local _, winid = vim.diagnostic.open_float(nil, opts)
    if winid and vim.api.nvim_win_is_valid(winid) then
      vim.api.nvim_win_set_height(winid, 5);
      vim.api.nvim_win_set_width(winid, 60);
    end
  end
  , {})