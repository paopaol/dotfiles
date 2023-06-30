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

    show_tab_indicators = false, -- | false,
    separator_style = "thin", -- | "padded_slant" | "thick" | "thin" |
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
