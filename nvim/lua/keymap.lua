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



unsilent_keymap("i", "<C-x><C-s>", "<c-\\><c-o>:w<cr>")
unsilent_keymap("n", "<C-x><C-s>", ":w<cr>")


-- remap << >>
keymap("x", ">", ">gv")
keymap("x", "<", "<gv")

-- terminal
keymap("t", "<esc>", "<C-\\><C-n>")

keymap("n", "n", ":Interestingwords --navigate<cr>")
keymap("n", "N", ":Interestingwords --navigate b<cr>")

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
