require("project_nvim").setup({
  manual_mode = true,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".projectile" },
  ignore_lsp = {},
  exclude_dirs = { "build" },
  show_hidden = false,
  silent_chdir = true,
  datapath = vim.fn.stdpath("data"),
})

require("telescope").load_extension("projects")
