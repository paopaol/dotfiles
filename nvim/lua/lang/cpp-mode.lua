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

_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<f5>"] = { start_debug, "debug", buffer = buf },
    ["<localleader>"] = {
      name = "major",

      [","] = { utils.format_buffer, "formatting", buffer = buf },
      ["o"] = { command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf },
      ["y"] = { command("CopyCppMethod"), "copy cpp method", buffer = buf },
      ["p"] = { command("PasteCppMethod"), "paste cpp method", buffer = buf },
      ["g"] = { command("TSCppDefineClassFunc"), "define class func", buffer = buf },
    },
  })
end

-- autocmd FileType cpp,c setlocal commentstring=//\ %s
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
