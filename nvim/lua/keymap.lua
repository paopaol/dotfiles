local keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end

local unsilent_keymap = function(mode, key, action)
  vim.api.nvim_set_keymap(mode, key, action, { noremap = true, silent = false })
end

_G.lsp_format_region = function()
  local r = vim.lsp.util.make_given_range_params()
  local line1 = r.range.start.line + 1
  local line2 = r.range['end'].line + 1
  vim.lsp.buf.format { range = { start = { line1, 0 }, ["end"] = { line2, 0 } } }
end
vim.api.nvim_create_user_command("LspFormatRegion", lsp_format_region, { range = 2 })

-- begin of line
keymap("i", "<C-a>", "<Home>")
unsilent_keymap("c", "<C-a>", "<Home>")


unsilent_keymap("i", "<C-x><C-s>", "<c-\\><c-o>:w<cr>")
unsilent_keymap("n", "<C-x><C-s>", ":w<cr>")

-- end of line
keymap("n", "<C-e>", "<End>a")
keymap("i", "<C-e>", "<End>")
keymap("v", "<C-e>", "<esc><End>a")
unsilent_keymap("c", "<C-e>", "<End>")

-- backward char
keymap("n", "<C-b>", "<Left>")
keymap("i", "<C-b>", "<Left>")
keymap("v", "<C-b>", "<Left>")
unsilent_keymap("c", "<C-b>", "<Left>")
keymap("i", "<A-b>", "<C-Left>")

-- forward char
keymap("n", "<C-f>", "<Right>")
keymap("i", "<C-f>", "<Right>")
keymap("v", "<C-f>", "<Right>")
unsilent_keymap("c", "<C-f>", "<Right>")
keymap("i", "<A-f>", "<C-Right>")
keymap("i", "<A-b>", "<C-Left>")

---next line
unsilent_keymap("c", "<C-j>", "<Down>")
keymap("i", "<C-j>", "<Down>")
keymap("n", "<C-j>", "5j")

-- previus line
unsilent_keymap("c", "<C-k>", "<Up>")
keymap("i", "<C-k>", "<Up>")
keymap("n", "<C-k>", "5k")

-- leave insert
keymap("i", "<C-c>", "<esc>")
keymap("n", "Q", ":cclose<CR>")
keymap("v", "Q", ":cclose<CR>")

-- window navigate
keymap("", "<A-j>", "<C-W>j")
keymap("", "<A-k>", "<C-W>k")
keymap("", "<A-h>", "<C-W>h")
keymap("", "<A-l>", "<C-W>l")

keymap("n", "<A-->", ":resize -1<CR>")
keymap("n", "<A-=>", ":resize +1<CR>")


keymap("n", "<A-<>", ":SidewaysLeft<CR>")
keymap("n", "<A->>", ":SidewaysRight<CR>")

-- remap << >>
keymap("x", ">", ">gv")
keymap("x", "<", "<gv")

-- terminal
keymap("t", "<esc>", "<C-\\><C-n>")

-- virual mode,which-key works bad
keymap("v", ",!", ":!bash<cr>")
keymap("v", ",tt", ":Translate<cr>")
keymap("v", ",,", "<esc><cmd>lua lsp_format_region()<CR>")
keymap("v", "gf", ":lua require('base.search').extract() <cr>")
keymap("v", ",g", ":TSCppDefineClassFunc<cr>")

---move line down or up
keymap("n", "<A-Down>", ":MoveLine(1)<CR>")
keymap("n", "<A-Up>", ":MoveLine(-1)<CR>")
keymap("v", "<A-Down>", ":MoveBlock(1)<CR>")
keymap("v", "<A-Up>", ":MoveBlock(-1)<CR>")

keymap("n", "n", ":Interestingwords --navigate<cr>")
keymap("n", "N", ":Interestingwords --navigate b<cr>")

keymap("n", "<A-x>", ":")
keymap("v", "<A-x>", ":")

keymap("v", "gy", ":lua ___gdc('v')<cr>")


keymap("v", "<leader>tv", ":lua require('edit.hex-view').view() <cr>")

vim.api.nvim_create_user_command("LineDiagnostic", function()
  local opts = {
    focusable = true,
    border = "rounded",
    prefix = "",
  }
  local _, winid = vim.diagnostic.open_float(nil, opts)
  if winid and vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_win_set_height(winid, 5)
    vim.api.nvim_win_set_width(winid, 60)
  end
end, {})



vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
