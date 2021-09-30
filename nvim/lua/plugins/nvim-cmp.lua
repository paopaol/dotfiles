local cmp = require 'cmp'
cmp.setup({
  snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    -- ['<Tab>'] = cmp.mapping(function()
    --   vim.fn["UltiSnips#ExpandSnippetOrJump"]()
    -- end, {'i', 's'})
  },
  sources = {{name = 'nvim_lsp'}, {name = 'ultisnips'}, {name = 'buffer'}}
  -- formatting = {
  --    format = function(entry, vim_item)
  --    vim_item.kind = lspkind.presets.default[vim_item.kind]
  --    return vim_item
  -- end
  -- }
})
