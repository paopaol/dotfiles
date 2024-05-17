return {
  {
    "akinsho/nvim-bufferline.lua",
    commit = "f6f00d9ac1a51483ac78418f9e63126119a70709",
    config = function()
      require "bufferline".setup {
        options = {
          buffer_close_icon = 'X',
          -- mode = "tabs", -- can also be set to "tabs" to see tabpages
          view = 'multiwindow', -- {'multiwindow'} | {'default'},
          themable = false,
          numbers = "ordinal",
          custom_filter = function(buf, buf_nums)
            return vim.bo[buf].filetype ~= "qf"
          end,

          show_tab_indicators = false,  -- | false,
          separator_style = "thin",     -- | "padded_slant" | "thick" | "thin" |
          enforce_regular_tabs = false, -- false | true,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left" -- "center" | "right" | "left"
            }
          }
        }
      }
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local utils = require("base.utils")

      local function project_name()
        -- return vim.fn.fnamemodify(utils.rootdir(), ':t')
        return ""
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "/", right = "/" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { project_name, "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end
  },
  { "p00f/nvim-ts-rainbow",   lazy = true },
  "paopaol/messages.nvim",
 { 'windwp/nvim-ts-autotag', lazy = true },
  'jinh0/eyeliner.nvim',
}
