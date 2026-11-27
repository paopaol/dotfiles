return {
  cmd = { "neocmakelsp", "stdio" },
  filetypes = { "cmake" },
  single_file_support = true,
  init_options = {
    format = {
      enable = false,
    },
    scan_cmake_in_package = true,
  },
  root_markers = { ".projectile" },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end,
}
