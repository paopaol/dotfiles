local cmp = require 'cmp'
cmp.setup({
  completion = {keyword_length = 1},
  experimental = {view = {entries = "native"}},
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  mapping = {
    ['<C-e>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("startinsert!")
    end, {'i'}),
    ['<C-f>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! l")
      vim.cmd("startinsert")
    end, {'s'}),
    ['<C-b>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! h")
      vim.cmd("startinsert")
    end, {'s'}),
    ['<C-a>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! 0")
    end, {'s'}),

    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'}
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

--------------------------------------------------------------------------------
