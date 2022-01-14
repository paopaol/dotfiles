-- Setup nvim-cmp.
local cmp = require 'cmp'
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
-- completion.keyword_length~
cmp.setup({
  completion = {keyword_length = 1},
  experimental = {native_menu = true},
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end, {"i", "s", "c"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end, {"i", "s", "c"}),
    ['<C-e>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("startinsert!")
    end, {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! l")
      vim.cmd("startinsert")
    end, {'i', 'c'}),
    ['<C-a>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! 0")
    end, {'i', 'c'}),

    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}
    -- , {name = 'ultisnips'}
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

--------------------------------------------------------------------------------
-- 

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
require('lspconfig').clangd.setup {capabilities = capabilities}
