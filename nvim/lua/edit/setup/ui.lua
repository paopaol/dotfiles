return {
  {
    -- 图标来源，替代 nvim-web-devicons；mock 让 lualine/neo-tree 等无感
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
      require("bufferline").setup({
        options = {
          buffer_close_icon = "X",
          view = "multiwindow",
          themable = false,
          numbers = "ordinal",
          custom_filter = function(buf, buf_nums)
            return vim.bo[buf].filetype ~= "qf"
          end,

          show_tab_indicators = false,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })
    end,
  },

  {
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    dependencies = { "tpope/vim-fugitive", "skywind3000/asyncrun.vim" },
    config = function()
      local sl = require("mini.statusline")

      local function git()
        local ok, head = pcall(vim.fn.FugitiveHead)
        return (ok and head ~= "") and (" " .. head) or ""
      end

      local function filename()
        if vim.bo.buftype ~= "" then
          return "%t"
        end
        local name = vim.api.nvim_buf_get_name(0)
        if name == "" then
          return "[No Name]"
        end
        local root = vim.call("asyncrun#get_root", "%")
        local rel = root ~= "" and vim.fs.relpath(root, name) or vim.fn.fnamemodify(name, ":t")
        return rel:gsub("%%", "%%%%") .. "%m%r"
      end

      sl.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = sl.section_mode({ trunc_width = 120 })
            local diagnostics = sl.section_diagnostics({ trunc_width = 150 })
            local fileinfo = sl.section_fileinfo({ trunc_width = 120 })
            local location = sl.section_location({ trunc_width = 75 })
            return sl.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { git(), diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename() } },
              "%=",
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { location } },
            })
          end,
        },
      })
    end,
  },

  { "paopaol/messages.nvim", event = "VeryLazy", config = true },

  { "windwp/nvim-ts-autotag", event = "VeryLazy" },

  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
      })
    end,
  },
}
