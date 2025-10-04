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
  { "<localleader>o", command("ClangdSwitchSourceHeader"), desc = "switch cc/h" },
  { "<localleader>y", command("CopyCppMethod"), desc = "copy cpp method" },
  { "<localleader>p", command("PasteCppMethod"), desc = "paste cpp method" },
  { "<localleader>g", command("TSCppDefineClassFunc"), desc = "define class func" },
})

vim.cmd([[
augroup filetype_cpp
autocmd!
autocmd FileType cpp,c set tabstop=4  shiftwidth=4  softtabstop=4 expandtab
autocmd FileType cpp,c TSEnable highlight
autocmd FileType cmake TSEnable highlight
autocmd FileType cpp,c highlight @lsp.type.number  ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
autocmd FileType cpp,c highlight @lsp.type.keyword ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
augroup END
]])

require("clangd_extensions").setup({
  inlay_hints = {
    inline = false,
    only_current_line = false,
    only_current_line_autocmd = { "CursorHold" },
    show_parameter_hints = true,
    parameter_hints_prefix = "<- ",
    other_hints_prefix = "=> ",
    max_len_align = false,
    max_len_align_padding = 1,
    right_align = false,
    right_align_padding = 7,
    highlight = "Comment",
    priority = 100,
  },

  ast = {
    role_icons = {
      type = "",
      declaration = "",
      expression = "",
      statement = ";",
      specifier = "",
      ["template argument"] = "",
    },
    kind_icons = {
      Compound = "",
      Recovery = "",
      TranslationUnit = "",
      PackExpansion = "",
      TemplateTypeParm = "",
      TemplateTemplateParm = "",
      TemplateParamObject = "",
    },
    highlights = {
      detail = "Comment",
    },
  },

  memory_usage = {
    border = "none",
  },

  symbol_info = {
    border = "none",
  },
})
