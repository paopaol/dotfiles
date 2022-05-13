-- Telescope.nvim configuration
local ts = require('telescope')
local actions = require('telescope.actions')

ts.setup({
  defaults = require("telescope.themes").get_ivy({
    -- results_title = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    max_results = 100,
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    color_devicons = true,
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
        width = 0.99
      },
      flex = {
        preview_width = 0.65,
        horizontal = {},
      },
      bottom_pane = {
        height = 0.3,
        preview_cutoff = 130,
        prompt_position = "top"
      },
    },
    borderchars = {
      -- prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
      -- preview = { " ", " ", " ", " ", " ", " ", " ", " " },
      -- results = { "─", " ", " ", " ", "─", "─", " ", " " },
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  })
})

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<C-h>"] = actions.which_key
      },
      n = { ["<esc>"] = actions.close }
    }
  }
}


require("telescope").setup {
  extensions = {
    file_browser = {
      theme = nil,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        }
      }
    }
  }
}
require("telescope").load_extension "file_browser"

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('vim_bookmarks')
require('telescope').load_extension('luasnip')

local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions
require('telescope').extensions.vim_bookmarks.all {
  attach_mappings = function(_, map)
    map('i', '<A-x>', bookmark_actions.delete_selected_or_at_cursor)
    return true
  end
}


require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("ui-select")




