vim.lsp.config('gopls', { 
  root_markers = {"compile_commands.json", "compile_flags.txt", ".git", ".projectile"},
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end
})
