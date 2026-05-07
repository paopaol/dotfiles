return {
  { "paopaol/cpp-mode", ft = { "c", "cpp" } },

  {
    "Badhi/nvim-treesitter-cpp-tools",
    branch = "main",
    ft = { "c", "cpp" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
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
    end,
  },

  { "plasticboy/vim-markdown", ft = "markdown" },

  { "jakewvincent/mkdnflow.nvim", ft = "markdown", rocks = "luautf8" },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  { "mklabs/vim-json", ft = "json" },

  { "cespare/vim-toml", ft = "toml" },

  { "othree/html5.vim", ft = "html" },

  { "matveyt/vim-qmake", ft = "pro" },

  { "folke/lua-dev.nvim", ft = "lua", branch = "main" },

  { "rafamadriz/friendly-snippets", branch = "main" },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    config = function()
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
    end,
  },
}
