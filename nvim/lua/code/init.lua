require("telescope").load_extension("projects")

require('lspkind').init({
  mode = 'symbol_text',
  preset = 'codicons',
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
  }
})

require("project_nvim").setup({
  manual_mode = true,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".projectile" },
  ignore_lsp = {},
  exclude_dirs = { "build" },
  show_hidden = false,
  silent_chdir = true,
  datapath = vim.fn.stdpath("data"),
})



require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "json", "html", "lua", "vim", "vimdoc", "query", "bash" },
  indent = { enable = false },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      local max_lines = 2000
      local ok, lines = pcall(vim.api.nvim_buf_line_count, buf)
      if ok and lines and lines > max_lines then
        return true
      end
    end,
  },
  incremental_selection = { enable = false, keymaps = { node_incremental = "vv" } },
  textobjects = {
    enable = true,
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { ["]]"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
  },
})
