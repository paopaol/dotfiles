require'window-picker'.setup({})
require("neo-tree").setup({
  popup_border_style = "double",
  source_selector = {
    winbar = false,
    statusline = true
  },
  window = {
    width = 50,
    mappings = {
      ["<tab>"] = {
	"toggle_node",
	nowait = false,
      },
      ["S"] = "split_with_window_picker",
      ["s"] = "vsplit_with_window_picker",
    }
  }
})
