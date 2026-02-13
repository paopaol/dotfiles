local wk = require("which-key")
local utils = require("base.utils")

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
      },
    },
  },
}

-- start debug or edit lanuch json
local start_debug = function()
  local root = string.format("%s/.vscode/launch.json", utils.rootdir())

  if vim.fn.filereadable(root) == 1 then
    require("dap.ext.vscode").load_launchjs("cppdbg", { cppdbg = { "c", "cpp" } })
    vim.cmd("DapContinue")
    return
  end

  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  if ft == "cpp" or ft == "c" then
    vim.cmd(string.format("edit %s", root))
    vim.fn.append(vim.fn.line("$"), vim.fn.json_encode(template))
  end
end

require("base.utils").make_keymap({ "cpp", "c", "cmake" }, "cc-group", {
  {
    "<f5>",
    start_debug,
    desc = "debug",
    buffer = vim.api.nvim_get_current_buf(),
  },
  { "<localleader>,", utils.format_buffer, desc = "formatting" },
  { "<localleader>g", command("TSCppDefineClassFunc"), desc = "define class func" },
})

vim.cmd([[
augroup filetype_cpp
autocmd!
autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab
autocmd FileType cpp,c highlight @lsp.type.number  ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
autocmd FileType cpp,c highlight @lsp.type.keyword ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
augroup END
]])
