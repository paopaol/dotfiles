vim.lsp.config("lua_ls", {
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
        library = {
          vim.fn.expand("/home/jz/workspace/jz/dotfiles/wireshark"),
          vim.api.nvim_get_runtime_file("", true),
        },
        checkThirdParty = false,
      },
    },
  },
})
