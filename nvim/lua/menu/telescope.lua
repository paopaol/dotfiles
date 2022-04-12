-- Telescope.nvim configuration
local ts = require('telescope')
local actions = require('telescope.actions')
local entry_display = require('telescope.pickers.entry_display')
local utils = require('telescope.utils')

ts.setup({
  defaults = {
    preview = nil,
    prompt_prefix = ">",

    sorting_strategy = "ascending",
    initial_mode = "insert",
    selection_strategy = "reset",
    layout_strategy = "vertical",
    -- file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    -- generic_sorter = require'telescope.sorters'.get_fuzzy_file,
    winblend = 0,
    layout_config = {
      width = 0.99,
      bottom_pane = {height = 25, preview_cutoff = 120, prompt_position = "top"},
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = "top",
        width = 0.5
      },
      cursor = {height = 0.9, preview_cutoff = 40, width = 0.8},
      horizontal = {
        height = 0.9,
        preview_cutoff = 120,
        prompt_position = "bottom",
        width = 0.8
      },
      vertical = {
        height = 0.8,
        preview_cutoff = 40,
        prompt_position = "bottom",
        width = 0.9
      }
    },
    max_results = 100,

    border = nil,
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = false,
    set_env = {['COLORTERM'] = 'truecolor'} -- default = nil,
  }
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
      n = {["<esc>"] = actions.close}
    }
  }
}

local MyTelescope = {}

function MyTelescope.entry_gen_from_buffers(opts)
  local displayer = entry_display.create {
    separator = " | ",
    items = {{width = 50}, {width = 300}, {remaining = true}}
  }

  local make_display = function(entry)
    local hl_group
    local basename = vim.fn.fnamemodify(entry.value, ":t")
    local dir = vim.fn.fnamemodify(entry.value, ":p:h")

    if basename == "" then basename = "[No Name]" end

    basename, hl_group = utils.transform_devicons(entry.value, basename, false)
    return displayer {{basename, hl_group}, dir}
  end

  return function(entry)
    return {
      value = entry.info.name,
      ordinal = entry.info.name,
      display = make_display
    }
  end
end

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
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
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

return MyTelescope
