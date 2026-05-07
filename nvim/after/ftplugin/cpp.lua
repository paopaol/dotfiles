vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

vim.treesitter.start()

local utils = require("base.utils")

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
  { "<localleader>o", utils.command("ClangdSwitchSourceHeader"), desc = "switch cc/h", buffer = true },
  { "<localleader>g", utils.command("TSCppDefineClassFunc"), desc = "define class func", buffer = true },
})

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

require("nt-cpp-tools").setup({
  preview = {
    quit = "q", -- optional keymapping for quit preview
    accept = "<tab>", -- optional keymapping for accept preview
  },
  header_extension = "h", -- optional
  source_extension = "cxx", -- optional
  custom_define_class_function_commands = {
    TSCppImplWrite = {
      output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
    },
  },
})
