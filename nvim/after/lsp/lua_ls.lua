local library = { vim.api.nvim_get_runtime_file("", true) }

return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      workspace = {
        library = library,
        checkThirdParty = false,
      },
    },
  },
}
