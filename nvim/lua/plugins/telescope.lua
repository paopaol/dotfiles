-- Telescope.nvim configuration
local ts = require('telescope')
local actions = require('telescope.actions')
local entry_display = require('telescope.pickers.entry_display')
local utils = require('telescope.utils')

ts.setup({
  defaults = {
    prompt_prefix = " ",

    vimgrep_arguments = {'ag', '--nogroup', '--nocolor', '--column'},
    prompt_position = "top",
    sorting_strategy = "ascending",
    initial_mode = "insert",
    selection_strategy = "reset",
    layout_strategy = "vertical",
    layout_defaults = {
      horizontal = {mirror = false},
      vertical = {mirror = true, preview_height = 25}
    },
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    -- generic_sorter = require'telescope.sorters'.get_fuzzy_file,
    winblend = 0,
    width = 0.90,
    max_results = 30,
    preview_cutoff = 120,

    border = {},
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

return MyTelescope
