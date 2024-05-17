return {
  "AndrewRadev/sideways.vim",
  { "fedepujol/move.nvim",    branch = "main" },
  { "mg979/vim-visual-multi", lazy = false },
  {
    "pseewald/vim-anyfold",
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
    branch = "main",
    config = function()
      require("todo-comments").setup {
        signs = true,      -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } }
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          before = "",                            -- "fg" or "bg" or empty
          keyword = "wide",                       -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          after = "fg",                           -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*\(\w*\):]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true,                   -- uses treesitter to match keywords in comments only
          max_line_len = 400,                     -- ignore lines longer than this
          exclude = {}                            -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
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
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]] -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        }

      }
    end
  },
  {
    "jbyuki/venn.nvim",
    config = function()
      function _G.Toggle_venn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
          vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
          -- draw a box by pressing "f" with visual selection
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
    config = function()
      require("Comment").setup({})

      local U = require("Comment.utils")
      local api = require("Comment.api")
      local A = vim.api

      function _G.___gdc(vmode)
        local range = U.get_region(vmode)
        local cfg = require("Comment.config").config
        local ctx = {
          cmode = U.cmode.toggle,   -- Always comment the line
          cmotion = U.cmotion.line, -- Line action `gy2j`
          ctype = U.ctype.line,     -- Use line style comment
          range = range,
        }

        local lines = U.get_lines(range)

        -- Copying the block
        local srow = ctx.range.erow
        A.nvim_buf_set_lines(0, srow, srow, false, lines)

        -- Doing the comment
        api.toggle.linewise(vmode)

        -- Move the cursor
        local erow = srow + 1
        local line = U.get_lines({ srow = srow, erow = erow })
        local _, col = string.find(line[1], "^%s*")
        A.nvim_win_set_cursor(0, { erow, col })
      end
    end
  },
  "voldikss/vim-translator",
  {
    "MattesGroeger/vim-bookmarks",
    config = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end
  },
  "godlygeek/tabular",
  {
    "chentoast/marks.nvim",
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
  {
    "lilydjwg/fcitx.vim",
    branch = "fcitx5",
    config = function()
      vim.g.fcitx5_remote = 'fcitx-remote'
    end
  },
  "mbbill/fencview",
}
