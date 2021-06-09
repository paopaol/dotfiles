require('formatter').setup({
  logging = false,
  filetype = {
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
