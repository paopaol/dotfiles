return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      's1n7ax/nvim-window-picker',
    },
    cmd = "Neotree",
    opts = {
      enable_diagnostics = false,
      enable_git_status = false,
      use_popups_for_input = false,
      popup_border_style = "double",
      source_selector = { winbar = false, statusline = true },
      window = {
        width = 50,
        mappings = {
          ["<tab>"] = { "toggle_node", nowait = false, },
          ["<cr>"] = "open_with_window_picker",
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
          ["C"] = { "copy", config = { show_path = "absolute" } },
          ["m"] = { "move", config = { show_path = "absolute" } },
        }
      }
    },
    config = function(_, opts)
      require 'window-picker'.setup({})
      require("neo-tree").setup(opts)
    end
  },
}
