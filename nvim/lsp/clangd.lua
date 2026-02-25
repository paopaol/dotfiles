vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "-j",
    "1",
    "--background-index=true",
    "--background-index-priority=low",
    "--pch-storage=disk",
    "--log=error",
    "--clang-tidy",
    "--header-insertion=never",
    "--compile-commands-dir=build",
    "--completion-style=detailed",
    "--limit-results=20",
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git", ".projectile" },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if vim.api.nvim_buf_line_count(bufnr) > 5000 then
      vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr })
      vim.diagnostic.enable(false, { bufnr = bufnr })
      vim.notify("文件超过 5000 行，已禁用 LSP 语义高亮以提升性能", vim.log.levels.WARN)
    end
  end,
})
