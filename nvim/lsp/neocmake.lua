vim.lsp.config('neocmake',  {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  single_file_support = true, -- suggested
  init_options = {
    format = {
      enable = false
    },
    scan_cmake_in_package = true -- default is true
  },
  root_markers = {"compile_commands.json", "compile_flags.txt", ".git", ".projectile"},
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end
})
