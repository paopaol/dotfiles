vim.lsp.config('clangd' ,{
  cmd = {
    "clangd",
    "-j",
    "1",
    "--background-index",
    "--background-index-priority=low",
    "--pch-storage=disk",
    "--log=error",
    "--clang-tidy",
    "--header-insertion=never",
    "--compile-commands-dir=build",
    "--completion-style=detailed",
    "--limit-results=20",
  },
  root_markers = {"compile_commands.json", "compile_flags.txt", ".git", ".projectile"},
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end
})
