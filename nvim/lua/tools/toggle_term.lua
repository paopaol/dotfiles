local vimshell = vim.o.shell
if vim.fn.has("win32") == 1 then
  vimshell = "powershell"
end

require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
  open_mapping = [[<c-\>]],
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
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
  shell = vimshell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    -- winblend = 3,
  },
})

vim.cmd([[autocmd TermEnter term://*toggleterm#* set winhighlight=]])

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  -- vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set("t", "<A-k>", [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set("t", "<A-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("n", "<A-h>", [[]], opts)
  vim.keymap.set("n", "<A-j>", [[]], opts)
  vim.keymap.set("n", "<A-k>", [[]], opts)
  vim.keymap.set("n", "<A-l>", [[]], opts)
  vim.keymap.set("t", "<C-j>", [[<Down>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Up>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
