local wk = require("which-key")
local utils = require('base.utils')

local function command(cmd) return function() vim.cmd(cmd) end end

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
            ignoreFailures = true
          }
        }
      }
    },
    Attach = {
      adapter = "vscode-cpptools",
      configuration = {
        request = "attach",
        program = "<path to binary>",
        MIMode = "<lldb or gdb>"
      }
    }
  }
}

-- start debug or edit lanuch json
local start_debug = function()
  local root = string.format("%s/.vimspector.json", utils.rootdir())

  if vim.fn.filereadable(root) == 1 then
    vim.call('vimspector#Continue')
    return
  end

  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  print(ft)
  if ft == 'cpp' or ft == 'c' then
    vim.cmd(string.format("edit %s", root))
    vim.fn.append(vim.fn.line('$'), vim.fn.json_encode(template))
  end
end

_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<f5>"] = {start_debug, "debug", buffer = buf},
    ["<localleader>"] = {
      name = "major",

      [","] = {vim.lsp.buf.formatting, "formatting", buffer = buf},
      ["o"] = {command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf},
      ["d"] = {command("Dox"), "doxgen", buffer = buf},
      ["y"] = {command("CopyCppMethod"), "copy cpp method", buffer = buf},
      ["p"] = {command("PasteCppMethod"), "paste cpp method", buffer = buf}
    }
  })
end

vim.cmd(([[
augroup filetype_cpp
	autocmd!
	autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab  
    autocmd FileType cpp,c lua whichkeyrCpp()
augroup END
]]))
