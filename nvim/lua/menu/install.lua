return {
  { "nanotee/zoxide.vim", event = "VeryLazy" },

  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = require("menu.setup.snacks"),
  },

  {
    "JonLD/snacks-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    -- C-w 回上级/删词在 menu/setup/snacks.lua 里注入，详见 setup_file_browser
    opts = {
      keymaps = { enter = "<Tab>" },
    },
  },
}
