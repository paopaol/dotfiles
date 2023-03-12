local wk = require("which-key")
local utils = require("base.utils")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

-- debug template
local template = {
  configurations = {
    Launch = {
      adapter = "vscode-cpptools",
      configuration = {
        request = "launch",
        program = "${workspaceRoot}/build/main",
        args = {},
        cwd = "${workspaceRoot}/build",
        environment = {},
        externalConsole = true,
        MIMode = "gdb",
        setupCommands = {
          {
            description = "Enable pretty-printing for gdb",
            text = "-enable-pretty-printing",
            ignoreFailures = true,
          },
        },
      },
    },
    Attach = {
      adapter = "vscode-cpptools",
      configuration = {
        request = "attach",
        program = "<path to binary>",
        MIMode = "<lldb or gdb>",
      },
    },
  },
}

-- start debug or edit lanuch json
local start_debug = function()
  local root = string.format("%s/.vimspector.json", utils.rootdir())

  if vim.fn.filereadable(root) == 1 then
    vim.call("vimspector#Continue")
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
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    -- ["<f5>"] = { start_debug, "debug", buffer = buf },
    ["<localleader>"] = {
      name = "major",

      [","] = { utils.format_buffer, "formatting", buffer = buf },
      ["o"] = { command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf },
      ["y"] = { command("CopyCppMethod"), "copy cpp method", buffer = buf },
      ["p"] = { command("PasteCppMethod"), "paste cpp method", buffer = buf },
      ["g"] = { command("TSCppDefineClassFunc"), "define class func", buffer = buf },
      ["ts"] = { gtest_set_cmd, "gtest set cmd", buffer = buf },
      ["t,"] = { gtest_run_selected, "gtest run", buffer = buf },
      ["tr"] = { command("GTestRunUnderCursor"), "run gtest under cursor", buffer = buf },
    },
  })
end

vim.cmd([[
augroup filetype_cpp
autocmd!
autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab  
autocmd FileType cpp,c lua whichkeyrCpp()
augroup END
]])


require("cmake-tools").setup({
  cmake_command = "cmake",
  cmake_build_directory = "build",
  cmake_build_type = "Debug",
  cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
  cmake_build_options = {},
  cmake_console_size = 10, -- cmake output window height
  cmake_show_console = "always", -- "always", "only_on_error"
  --cmake_dap_configuration = { name = "cpp", type = "vscode-cpptools", request = "launch" }, -- dap configuration, optional
  --cmake_dap_open_command = require("dap").repl.open, -- optional
})
