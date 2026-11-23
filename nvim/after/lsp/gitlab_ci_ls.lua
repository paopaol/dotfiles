return {
  cmd = { "gitlab-ci-ls" },
  root_markers = { ".projectile" },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
}
