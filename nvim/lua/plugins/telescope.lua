-- Telescope.nvim configuration
local ts = require('telescope')
local actions = require('telescope.actions')
local entry_display = require('telescope.pickers.entry_display')
local utils = require('telescope.utils')

ts.setup({
  defaults = {
    preview = nil,
    prompt_prefix = " ",

    vimgrep_arguments = {'ag', '--nogroup', '--nocolor', '--column'},
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
      -- preview_cutoff = 120,
      -- prompt_position = "top",
      -- horizontal = {mirror = false},
      -- vertical = {mirror = true, preview_height = 25},

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
        height = 0.9,
        preview_cutoff = 40,
        prompt_position = "bottom",
        width = 0.8
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
        ["<esc>"] = actions.close
      },
      n = {["<esc>"] = actions.close}
    }
  }
}

local MyTelescope = {}

function MyTelescope.entry_gen_from_recentfiles(opts)
  local displayer = entry_display.create {
    separator = " | ",
    items = {{width = 50}, {width = 300}, {remaining = true}}
  }

  local make_display = function(entry)
    local hl_group
    local basename = vim.fn.fnamemodify(entry.value, ":t")
    local dir = vim.fn.fnamemodify(entry.value, ":p:h")

    basename, hl_group = utils.transform_devicons(entry.value, basename, false)
    return displayer {{basename, hl_group}, dir}
  end

  return function(entry)
    return {value = entry, ordinal = entry, display = make_display}
  end
end

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
      theme = "ivy",
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

return MyTelescope
