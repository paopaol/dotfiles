require 'nvim-treesitter.configs'.setup {
  indent = { enable = false },
  autotag = { enable = true },
  -- ensure_installed = {'bash', 'css', 'html', 'rust', 'toml', 'yaml', 'cpp', 'c'},
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = "gnn",
      node_incremental = "vv"
      -- scope_incremental = "grc",
      -- node_decremental = "grm"
    }
  },
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
        ["ic"] = "@class.inner"

      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { ["]]"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[c"] = "@class.outer"
      },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" }
    }
  },
  nt_cpp_tools = {
    enable = false,
    preview = {
      quit = 'q', -- optional keymapping for quit preview
      accept = '<tab>' -- optional keymapping for accept preview
    },
    custom_impl_commands = {
      TSCppImplWrite = {
        output_cb = require 'nvim-treesitter.nt-cpp-tools.output_handlers'.add_to_cpp
        -- output_cb = function(output, _)
        --   print(output)
        --   vim.fn.setreg(0, output)
        -- end
      }
      -- <custom_command> = { output_cb = <function (output_str, context)> }
    }
  }
}
