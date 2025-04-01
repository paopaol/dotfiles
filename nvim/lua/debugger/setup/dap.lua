local M = {}

local quit_window = function()
  pcall(vim.cmd, [[wincmd c]])
end

local make_keymap = function(ft, name, keymap)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup(name, { clear = true }),
    pattern = ft,
    callback = function()
      local wk = require("which-key")
      wk.add(keymap)
    end,
  })
end

local opts = function()
  return {
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
end


M.config = function()
  local dap, dapui = require("dap"), require("dapui")
  local wk = require("which-key")

  require("nvim-dap-virtual-text").setup({})

  dapui.setup(opts())
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = string.format('%s/mason/bin/OpenDebugAD7', vim.fn.stdpath('data')),
  }
  vim.fn.sign_define('DapBreakpoint',
    { text = '●', texthl = '', linehl = 'DapUIBreakpointsCurrentLine', numhl = 'DapUILineNumber' })
  dap.listeners.after.event_initialized["dapui_config"] = dapui.open
  dap.listeners.before.event_terminated["dapui_config"] = dapui.close
  dap.listeners.before.event_exited["dapui_config"] = dapui.close
  dap.listeners.before.disconnect["dapui_config"] = dapui.close

  make_keymap("dap-float", "dap-group", {
    { "q", quit_window, desc = "quit", buffer = vim.api.nvim_get_current_buf() },
  })
end


M.hover = function()
  local ft = vim.api.nvim_buf_get_option(0, "ft")
  if ft == 'dap-float' then
    return
  end
  local widgets = require('dap.ui.widgets')
  widgets.hover()
end

return M
