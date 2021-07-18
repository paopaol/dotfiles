vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = false,
  auto_preview = false,
  position = 'left',
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a"
  },
  lsp_blacklist = {}
}