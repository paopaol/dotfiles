vim.cmd([[set background=dark]])
vim.cmd("colorscheme dark_flat")
vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "Structure" })
vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "Type" })
