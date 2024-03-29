-- Telescope.nvim configuration
local ts = require("telescope")
local actions = require("telescope.actions")

ts.setup({
  defaults = require("telescope.themes").get_ivy({
    -- results_title = true,
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
  },
})

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        ["<C-h>"] = actions.which_key,
      },
      n = { ["<esc>"] = actions.close },
    },
  },
})

local fb_utils = require "telescope._extensions.file_browser.utils"
local file_browser_change_dir = function(path)
  local action_state = require "telescope.actions.state"

  local prompt_bufnr = vim.api.nvim_get_current_buf()
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  finder.path = path
  finder.files = true
  current_picker:refresh(finder, {
    reset_prompt = true,
    new_prefix = fb_utils.relative_path_prefix(finder)
  })
end

local update_dir = function(prompt)
  if prompt == "~/" then
    file_browser_change_dir(vim.env.HOME)
  elseif prompt == "/" then
    file_browser_change_dir("/")
  end
end


local lst = require('telescope').extensions.luasnip
local luasnip = require('luasnip')

local fb_actions = require "telescope._extensions.file_browser.actions"
require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = false,                  -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
    luasnip = {
      search = function(entry)
        return lst.filter_null(entry.context.trigger) .. " " ..
            lst.filter_null(entry.context.name) .. " " ..
            entry.ft .. " " ..
            lst.filter_description(entry.context.name, entry.context.description) ..
            lst.get_docstring(luasnip, entry.ft, entry.context)[1]
      end
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
    file_browser = {
      on_input_filter_cb = update_dir,
      theme = nil,
      use_fd = false,
      prompt_path = true,
      mappings = {
        ["i"] = {
          ["<C-w>"] = fb_actions.backspace,
          ["<bs>"] = fb_actions.backspace,
        },
      },
    },
  },
})


require("telescope").load_extension("fzf")
require("telescope").load_extension("heading")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("vim_bookmarks")
require("telescope").load_extension("git_diffs")
require("telescope").load_extension("command")
