vim.lsp.config("gitlab_ci_ls", {
  cmd = { "gitlab-ci-ls" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git", ".projectile" },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
})
