local cmp = require 'cmp'
local lspkind = require('lspkind')

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup({
  completion = { keyword_length = 1 },
  experimental = { view = { entries = "native" } },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  formatting = {
    format = function(entry, vim_item)
      local ELLIPSIS_CHAR = '…'
      local MAX_LABEL_WIDTH = 50
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      if truncated_label ~= label then
        vim_item.abbr = string.format('%s%s', truncated_label, ELLIPSIS_CHAR)
      end
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
        doxygen = "[Doxygen]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
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
    { name = 'nvim_lsp', max_item_count = 20 },
    { name = 'buffer', max_item_count = 20 },
    { name = 'luasnip', max_item_count = 20 },
    { name = 'nvim_lsp_signature_help', max_item_count = 20 },
    { name = 'path', max_item_count = 20 },
    -- { name = 'doxygen' },
    -- { name = 'copilot' }
  })
})


local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))


local compare = require('cmp.config.compare')
cmp.setup({
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
  -- completion = {
  --   autocomplete = true
  -- }
})
