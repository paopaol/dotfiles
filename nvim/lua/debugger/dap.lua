local dap, dapui = require("dap"), require("dapui")
local wk = require("which-key")
require("nvim-dap-virtual-text").setup({})

dapui.setup(
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "✕",
        pause = "▷",
        play = "▶",
        run_last = "⟲",
        step_back = "🗝",
        step_into = "→",
        step_out = "←",
        step_over = "↷",
        terminate = "■"
      }
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t",
    },
    icons = {
      collapsed = "c",
      current_frame = "c",
      expanded = "e"
    },
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25
      }, {
        id = "stacks",
        size = 0.25
      }, {
        id = "watches",
        size = 0.25
      } },
      position = "right",
      size = 40
    }, {
      elements = { {
        id = "repl",
        size = 0.5
      }, {
        id = "console",
        size = 0.5
      } },
      position = "bottom",
      size = 0.3
    } },
  }
)


dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = string.format('%s/mason/bin/OpenDebugAD7', vim.fn.stdpath('data')),
}
vim.fn.sign_define('DapBreakpoint',
  { text = '●', texthl = '', linehl = 'DapUIBreakpointsCurrentLine', numhl = 'DapUILineNumber' })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<f9>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set({ 'n', 'v' }, '<f12>', function()
  local ft = vim.api.nvim_buf_get_option(0, "ft")
  if ft == 'dap-float' then
    return
  end
  local widgets = require('dap.ui.widgets')
  widgets.hover()
end)


dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close
dap.listeners.before.disconnect["dapui_config"] = dapui.close


local quit_window = function()
  pcall(vim.cmd, [[wincmd c]])
end

_G.dapFloatinhKeymaps = function()
  wk.add({
    { "q", quit_window, desc = "quit", buffer = vim.api.nvim_get_current_buf() },
  })
end

vim.cmd([[
augroup dap_grp
  autocmd!
  autocmd FileType dap-float lua dapFloatinhKeymaps()
augroup END
]])
