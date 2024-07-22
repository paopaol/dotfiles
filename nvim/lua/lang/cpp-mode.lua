local wk = require("which-key")
local utils = require("base.utils")

-- require("cmake-tools").setup {
--   cmake_command = "cmake",
--   cmake_regenerate_on_save = nil,
--   cmake_build_directory = "build",
--   cmake_build_type = "Debug",
--   cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
-- }


local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

local template = {
  version = "0.3.0",
  configurations = {
    {
      type = "cppdbg",
      request = "launch",
      name = "Launch CPP",
      program = "${workspaceFolder}/build/main",
      args = {},
      cwd = "${workspaceFolder}/build",
      environment = {},
      externalConsole = false,
      linux = {
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        setupCommands = {
          {
            description = "Enable pretty-printing for gdb",
            text = "-enable-pretty-printing",
            ignoreFailures = true,
          },
        },
      }
    },
  },
}

-- start debug or edit lanuch json
local start_debug = function()
  local root = string.format("%s/.vscode/launch.json", utils.rootdir())

  if vim.fn.filereadable(root) == 1 then
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
    vim.cmd("DapContinue")
    return
  end

  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  print(ft)
  if ft == "cpp" or ft == "c" then
    vim.cmd(string.format("edit %s", root))
    vim.fn.append(vim.fn.line("$"), vim.fn.json_encode(template))
  end
end

local gtest_set_cmd = function()
  local cmake = require("cmake-tools")

  local callback = function()
    local cmake_config = require("cmake-tools.config"):get_launch_target()
    if cmake_config.data then
      vim.cmd(string.format("GTestCmd %s", cmake_config.data))
    end
  end

  cmake.select_launch_target(callback)
end

local gtest_run_selected = function()
  local cmake = require("cmake-tools")

  local callback = function()
    local cmake_config = require("cmake-tools.config"):get_launch_target()
    if cmake_config.data then
      vim.cmd(string.format("GTestCmd %s", cmake_config.data))

      local tests = vim.call('gtest#GetAllTests')
      vim.ui.select(tests, { prompt = "select test case" }, function(test)
        if not test then
          return
        end
        vim.call('gtest#GTestRunOnly', test)
      end)
    end
  end

  cmake.select_launch_target(callback)
end

_G.whichkeyrCpp = function()
  wk.add({
    { "<f5>",            start_debug,                         desc = "debug",                 buffer = vim.api.nvim_get_current_buf() },
    { "<localleader>,",  utils.format_buffer,                 desc = "formatting", },
    { "<localleader>o",  command("ClangdSwitchSourceHeader"), desc = "switch cc/h", },
    { "<localleader>y",  command("CopyCppMethod"),            desc = "copy cpp method", },
    { "<localleader>p",  command("PasteCppMethod"),           desc = "paste cpp method", },
    { "<localleader>g",  command("TSCppDefineClassFunc"),     desc = "define class func", },
    { "<localleader>ts", gtest_set_cmd,                       desc = "gtest set cmd", },
    { "<localleader>t,", gtest_run_selected,                  desc = "gtest run", },
    { "<localleader>tr", command("GTestRunUnderCursor"),      desc = "run gtest under cursor" },
  })
end

vim.cmd([[
augroup filetype_cpp
autocmd!
autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab
autocmd FileType cpp,c lua whichkeyrCpp()
autocmd FileType cpp,c TSDisable highlight
autocmd FileType cmake TSEnable highlight
autocmd FileType cpp,c highlight @lsp.type.number  ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
autocmd FileType cpp,c highlight @lsp.type.keyword ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
augroup END
]])
