local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
  completion = { keyword_length = 1 },
  experimental = { view = { entries = "native" } },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item) return vim_item end
    })
  },
  mapping = {
    ['<C-e>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("startinsert!")
    end, { 'i' }),
    ['<C-f>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! l")
      vim.cmd("startinsert")
    end, { 's' }),
    ['<C-b>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! h")
      vim.cmd("startinsert")
    end, { 's' }),
    ['<C-a>'] = cmp.mapping(function()
      cmp.close()
      vim.cmd("normal! 0")
    end, { 's' }),

    ['<backspace>'] = cmp.mapping(function()
      local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
      vim.api.nvim_feedkeys(key, 's', true)
      vim.api.nvim_feedkeys('c', 'v', true)
    end, { 's' }),
    ['<delete>'] = cmp.mapping(function()
      local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
      vim.api.nvim_feedkeys(key, 's', true);
      vim.api.nvim_feedkeys('c', 'v', true);
    end, { 's' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = cmp.mapping.confirm({ select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'luasnip' }, { name = 'nvim_lsp_signature_help' }, { name = 'path' }
  })
})


local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
