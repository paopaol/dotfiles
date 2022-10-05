local utils = require("base.utils")
local wk = require("which-key")

require("litee.lib").setup({
  tree = {
    icon_set = "codicons",
  },
  panel = {
    orientation = "bottom",
    panel_size = 30,
  },
})

require("litee.calltree").setup({
  resolve_symbols = true,
  -- the jump_mode used for jumping from
  -- calltree node to source code line.
  -- "invoking" will use the last window that invoked the calltree (feels natural)
  -- "neighbor" will use the closest neighbor opposite to the panel orientation
  -- (if panel is left, uses window to the right.)
  jump_mode = "invoking",
  -- enables hiding the cursor inside the Calltree UI.
  hide_cursor = false,
  -- Maps arrow keys to resizing the Calltree UI within the `litee.nvim` Panel.
  map_resize_keys = true,
  -- Disables all highlighting.
  no_hls = false,
  -- Determines if initial creation of a calltree opens in the
  -- Panel or in a Popout window. Options are "panel" or "popout"
  on_open = "panel",
  -- If true, disable all keymaps
  disable_keymaps = false,
  -- The default keymaps. Users can provide overrides
  -- to these mappings via the setup function.
  keymaps = {
    expand = "zo",
    collapse = "zc",
    collapse_all = "zM",
    jump = "<CR>",
    jump_split = "s",
    jump_vsplit = "v",
    jump_tab = "t",
    hover = "i",
    details = "d",
    close = "X",
    close_panel_pop_out = "<Esc>",
    help = "?",
    hide = "H",
    switch = "S",
    focus = "f",
  },
})

vim.lsp.handlers["callHierarchy/incomingCalls"] =
  vim.lsp.with(require("litee.calltree.handlers").ch_lsp_handler("from"), {})
vim.lsp.handlers["callHierarchy/outgoingCalls"] =
  vim.lsp.with(require("litee.calltree.handlers").ch_lsp_handler("to"), {})

-- vim.api.nvim_buf_set_keymap(0, "n", "q", ":LTClosePanelPopOut<CR>")
_G.jz_calltree = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["q"] = { utils.command("LTCloseCalltree"), "quit", buffer = buf },
    ["<tab>"] = { utils.command("LTExpandCalltree"), "expand", buffer = buf },
    ["<S-tab>"] = { utils.command("LTCollapseCalltree"), "collapse", buffer = buf },
    ["K"] = { utils.command("LTHoverCalltree"), "collapse", buffer = buf },
  })
end

vim.cmd([[
  autocmd FileType calltree lua jz_calltree()
]])
