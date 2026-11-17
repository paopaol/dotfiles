return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      's1n7ax/nvim-window-picker',
    },
    cmd = "Neotree",
    opts = {
      sources = { "filesystem" }, -- 只保留 Files，去掉 Buffers/Git
      enable_diagnostics = false,
      enable_git_status = false,
      use_popups_for_input = false,
      popup_border_style = "double",
      filesystem = {
        filtered_items = {
          -- 关闭 gitignore 过滤：该功能每次刷新都同步执行 git ls-files，大仓库很慢
          hide_gitignored = false,
        },
      },
      window = {
        width = 50,
        mappings = {
          ["<Tab>"] = { "toggle_node", nowait = false, },
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
