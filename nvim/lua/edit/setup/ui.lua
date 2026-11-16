return {
  {
    -- 图标来源，替代 nvim-web-devicons；mock 让 lualine/telescope/neo-tree 等无感
    "nvim-mini/mini.icons",
    lazy = false,
    priority = 100,
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },

  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
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
    -- 替代 lualine：默认轻量，内容保持 mode / git / diagnostics / 文件信息 / 位置
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    config = function()
      local sl = require("mini.statusline")
      sl.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = sl.section_mode({ trunc_width = 120 })
            local git = sl.section_git({ trunc_width = 75 })
            local diagnostics = sl.section_diagnostics({ trunc_width = 150 })
            local filename = sl.section_filename({ trunc_width = 140 })
            local fileinfo = sl.section_fileinfo({ trunc_width = 120 })
            local location = sl.section_location({ trunc_width = 75 })
            return sl.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            })
          end,
        },
      })
    end,
  },

  { "paopaol/messages.nvim",  event = "VeryLazy", config = true },

  { 'windwp/nvim-ts-autotag', event = "VeryLazy" },

  {
    'jinh0/eyeliner.nvim',
    event = "VeryLazy",
    config = function()
      require 'eyeliner'.setup {
        highlight_on_key = true,
        dim = true,
      }
    end
  }
}
