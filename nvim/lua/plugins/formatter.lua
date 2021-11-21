require('formatter').setup({
  logging = true,
  filetype = {
    cpp = {
      function() return {exe = "clang-format", args = {}, stdin = true} end
    },
    json = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    css = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    html = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    xml = {
      -- prettier
      function()
        return {
          exe = "/home/jz/node_modules/prettier/bin-prettier.js",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0),
									'--tab-width', '2', '--parser', 'xml' },
          stdin = true
        }
      end
    },
    rels = {
      -- prettier
      function()
        return {
          exe = "/home/jz/node_modules/prettier/bin-prettier.js",
					args = { '--tab-width', '2',
            '--bracket-same-line', 'true', '--xml-whitespace-sensitivity',
            'ignore', '--parser', 'xml'
          },
          stdin = true
        }
      end
    },
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    markdown = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--insert-pragma'
          },
          stdin = true
        }
      end
    },
    lua = {
      -- luafmt
      function()
        return {exe = "lua-format", args = {"--indent-width=2"}, stdin = true}
      end
    }
  }
})
