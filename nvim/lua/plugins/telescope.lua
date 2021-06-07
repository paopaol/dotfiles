-- Telescope.nvim configuration
local ts = require('telescope')
local actions = require('telescope.actions')


ts.setup({
  defaults = {
    prompt_prefix = " ",

    vimgrep_arguments = {
        'ag','--nogroup', '--nocolor', '--column',
    },
    prompt_position = "top",
    sorting_strategy = "ascending",
    initial_mode = "insert",
    selection_strategy = "reset",
    layout_strategy = "flex",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror  = true,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  },
})

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
      n = {
        ["<esc>"] = actions.close,
      },
    },
  }
}

