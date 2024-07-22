local wk = require("which-key")
local utils = require('base.utils')

local function command(cmd) return function() vim.cmd(cmd) end end

_G.whichkeyPython = function()
  wk.add({
    { "<localleader>,",  utils.format_buffer,                desc = "formatting" },
    { "<localleader>qd", utils.command("silent ! designer"), desc = "qt designer" },
  })
end

vim.cmd([[
augroup py_grp
  autocmd!
  autocmd FileType python  lua whichkeyPython()
augroup END
]])


local function files_of_current(match)
  local dir = vim.fn.expand("%:p:h")
  local files = vim.fn.split(vim.fn.globpath(dir, match), '\n')

  local results = {}
  for index, f in ipairs(files) do
    table.insert(results, vim.fn.fnamemodify(f, ':p:t'))
  end
  return results
end

local function filename_expand_info(filename, prefix)
  local dir = vim.fn.expand('%:p:h')
  local name = vim.fn.fnamemodify(filename, ':t:r')
  local out = dir .. prefix .. name .. '.py'
  local in_name = dir .. '/' .. name .. '.ui'
  return {
    input = in_name,
    output = out
  }
end

local pyqt5_ui_compile = function(opts)
  local args = filename_expand_info(opts.args, '/Ui_')
  vim.cmd(string.format('! pyuic5 -o %s %s', args.output, args.input))
end

vim.api.nvim_create_user_command("Pyqt5UiCompile", pyqt5_ui_compile, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return files_of_current("*.ui")
  end
})
