local M = {}

M.config = function()
  local actions = require("telescope.actions")

  require("telescope").setup({
    defaults = require("telescope.themes").get_ivy({
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<esc>"] = actions.close,
          ["<C-h>"] = actions.which_key,
        },
        n = { ["<esc>"] = actions.close },
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      max_results = 100,
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      color_devicons = true,
      scroll_strategy = "limit",
      layout_strategy = "vertical",
      initial_mode = "insert",
      layout_config = {
        width = 0.99,
        height = 0.3,
        preview_cutoff = 20,
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.65,
        },
        vertical = {
          preview_width = 0.99,
          width = 0.99,
          height = 100,
          preview_height = 0.6,
        },
        center = {
          height = 0.30,
          preview_cutoff = 40,
          prompt_position = "top",
          width = 0.99,
        },
        flex = {
          preview_width = 0.65,
          horizontal = {},
        },
        bottom_pane = {
          height = 0.3,
          preview_cutoff = 130,
          prompt_position = "top",
        },
      },
      borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
    }),
    pickers = {
      live_grep = {
        mappings = {
          i = { ["<c-f>"] = actions.to_fuzzy_refine },
        },
      },
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f", -- 只找文件
          "--strip-cwd-prefix", -- 移除路径前缀（美化显示）
          "--exclude",
          ".git", -- 排除 .git 目录
          "--exclude",
          "*.o", -- 排除编译后的对象文件
          "--exclude",
          "*.so*", -- 排除编译后的对象文件
          "--exclude",
          "*.o.d", -- 排除编译后的对象文件
          "--ignore-file",
          ".gitignore", -- 强制遵循 .gitignore（默认通常已开启）
        },
      },
    },
    extensions = {
      file_browser = {
        theme = nil,
        hijack_netrw = true,
        prompt_path = true,
        mappings = {
          ["i"] = {
            ["<C-w>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
          },
        },
      },
      fzf = {
        fuzzy = false, -- 开启模糊匹配
        override_generic_sorter = true, -- 覆盖通用排序器
        override_file_sorter = true, -- 覆盖文件排序器
        case_mode = "smart_case", -- 区分大小写策略
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("vim_bookmarks")
  require("telescope").load_extension("git_diffs")
  require("telescope").load_extension("file_browser")
end

return M
