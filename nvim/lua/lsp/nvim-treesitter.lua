require 'nvim-treesitter.configs'.setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 100,        -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  indent = { enable = false },
  autotag = { enable = true },
  -- ensure_installed = {'bash', 'css', 'html', 'rust', 'toml', 'yaml', 'cpp', 'c'},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
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
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
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
  }
}
require 'nt-cpp-tools'.setup({
  preview = {
    quit = 'q',             -- optional keymapping for quit preview
    accept = '<tab>'        -- optional keymapping for accept preview
  },
  header_extension = 'h',   -- optional
  source_extension = 'cxx', -- optional
  custom_define_class_function_commands = {
    -- optional
    TSCppImplWrite = {
      output_handle = require 'nt-cpp-tools.output_handlers'.get_add_to_cpp()
    }
    --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
  }
})

require("treesitter-context").setup({ enable = true, throttle = true })
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
  },
}

require("nvim-treesitter.parsers").list.xml = {
  install_info = {
    url = "https://github.com/Trivernis/tree-sitter-xml",
    files = { "src/parser.c" },
    generate_requires_npm = true,
    branch = "main",
  },
  filetype = "xml",
}


vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp,c',
  callback = function()
    vim.cmd([[TSDisable highlight]])
  end,
})
