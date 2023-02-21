require("dapui").setup(
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "🔌",
        pause = "💤",
        play = "🚀",
        run_last = "📌",
        step_back = "🗝",
        step_into = "s",
        step_out = "🛠",
        step_over = "📅",
        terminate = "⌘"
      }
    },
    icons = {
      collapsed = "c",
      current_frame = "c",
      expanded = "e"
    },
  }
)

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = string.format('%s/mason/bin/OpenDebugAD7', vim.fn.stdpath('data')),
}
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })


vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<f9>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<f12>', function()
  require('dap.ui.widgets').hover()
end)
-- vim.keymap.set({ 'n', 'v' }, '<f12>', function()
--   require('dap.ui.widgets').preview()
-- end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
