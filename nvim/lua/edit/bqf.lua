vim.cmd([[
    hi BqfPreviewBorder guifg=#50a14f ctermfg=71
    hi link BqfPreviewRange Search
]])

require('bqf').setup({
  auto_enable = false,
  auto_resize_height = false, -- highly recommended enable
  preview = {
    win_height = 20,
    win_vheight = 20,
    delay_syntax = 80,
    border_chars = {
      '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'
    },
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match('^fugitive://') then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end
  },
  -- make `drop` and `tab drop` to become preferred
  func_map = {
    drop = 'o',
    openc = 'O',
    split = '<C-s>',
    tabdrop = '<C-t>',
    tabc = '',
    ptogglemode = 'z,'
  }
})
