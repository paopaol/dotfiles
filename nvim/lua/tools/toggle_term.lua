require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  highlights = {
    -- highlights which map to a highlight group name and a table of it's values
    -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    Normal = {
      -- guibg = <VALUE-HERE>,
    },
    NormalFloat = {
      link = "Normal",
    },
    FloatBorder = {
      -- guifg = <VALUE-HERE>,
      -- guibg = <VALUE-HERE>,
    },
  },
  shade_terminals = true,
  shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = "float", --'vertical' | 'horizontal' | 'tab' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  float_opts = {},
})

-- 终端固定在项目根，而不是 autochdir 后的当前文件目录
local term = require("toggleterm.terminal").Terminal:new({ direction = "float" })

local function toggle_project_term()
  local dir = require("base.project").root()
  -- 已有终端时先切目录；直接赋值 term.dir 会让 change_dir 认为无需切换
  if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
    term:change_dir(dir)
  end
  term.dir = dir
  term:toggle()
end

vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_project_term, { desc = "terminal" })
vim.keymap.set("i", "<C-\\>", function()
  vim.cmd("stopinsert")
  toggle_project_term()
end, { desc = "terminal" })
