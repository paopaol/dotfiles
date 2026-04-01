local keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end

local unsilent_keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = false })
end


unsilent_keymap("i", "<C-x><C-s>", "<c-\\><c-o>:w<cr>")
unsilent_keymap("n", "<C-x><C-s>", ":w<cr>")

--- for blink.cmp snippets
vim.keymap.set("s", "<bs>", "<C-g>c", { desc = "delete selection in insert mode" })

-- remap << >>
keymap("x", ">", ">gv")
keymap("x", "<", "<gv")

-- terminal
keymap("t", "<esc>", "<C-\\><C-n>")

keymap("n", "n", ":Interestingwords --navigate<cr>")
keymap("n", "N", ":Interestingwords --navigate b<cr>")

