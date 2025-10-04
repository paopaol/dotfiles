return {
  { "AndrewRadev/sideways.vim", event = "VeryLazy" },

  { "fedepujol/move.nvim",      event = "VeryLazy" },

  { "mg979/vim-visual-multi",   event = "VeryLazy" },

  {
    "pseewald/vim-anyfold",
    event = "VeryLazy",
    config = function()
      local utils = require('base.utils')

      utils.keymap('n', 'zm', ':AnyFoldActivate<CR>zM')
      utils.keymap('v', 'zm', ':AnyFoldActivate<CR>zM')
      utils.keymap('n', 'zr', 'zR')
      utils.keymap('v', 'zr', 'zR')
    end
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup {
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } }
        },
        merge_keywords = true,
        highlight = { before = "", keyword = "wide", after = "fg", pattern = [[.*<(KEYWORDS)\s*\(\w*\):]], comments_only = true, max_line_len = 400, exclude = {} },
        colors = {
          error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
          info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
          hint = { "LspDiagnosticsDefaultHint", "#10B981" },
          default = { "Identifier", "#7C3AED" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column"
          },
          pattern = [[\b(KEYWORDS):]]
        }

      }
    end
  },

  {
    "jbyuki/venn.nvim",
    event = "VeryLazy",
    config = function()
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
        else
          vim.cmd [[setlocal ve=]]
          vim.cmd [[mapclear <buffer>]]
          vim.b.venn_enabled = nil
        end
      end
    end
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({})

      local U = require("Comment.utils")
      local api = require("Comment.api")
      local A = vim.api

      function _G.___gdc(vmode)
        local range = U.get_region(vmode)
        local ctx = { cmode = U.cmode.toggle, cmotion = U.cmotion.line, ctype = U.ctype.line, range = range }

        local lines = U.get_lines(range)

        local srow = ctx.range.erow
        A.nvim_buf_set_lines(0, srow, srow, false, lines)

        api.toggle.linewise(vmode)

        local erow = srow + 1
        local line = U.get_lines({ srow = srow, erow = erow })
        local _, col = string.find(line[1], "^%s*")
        A.nvim_win_set_cursor(0, { erow, col })
      end
    end
  },

  {
    "voldikss/vim-translator",
    event = "VeryLazy",
    config = function()
      vim.g.translator_default_engines = { 'google' }
      vim.g.translator_window_type = 'popup'
    end
  },

  {
    "MattesGroeger/vim-bookmarks",
    event = "VeryLazy",
    config = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end
  },

  { "godlygeek/tabular", event = "VeryLazy" },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require 'marks'.setup {
        default_mappings = true,
        builtin_marks = { ".", "<", ">", "^" },
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        excluded_filetypes = {},
        bookmark_0 = { sign = "⚑", virt_text = "hello world" },
        mappings = {}
      }
    end
  },
}
