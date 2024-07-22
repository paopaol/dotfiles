local wk = require("which-key")
local utils = require("base.utils")

local format = function()
  require("tools.markdown_formater.markdown").format_region()
  utils.format_buffer()
end

_G.whichkeyMarkdown = function()
  wk.add({
    { "<localleader>,", format,                                      desc = "formatting" },
    { "<localleader>p", utils.command("MarkdownPreview"),            desc = "preview" },
    { "<leader>si",     function() vim.cmd("Telescope heading") end, desc = "heading",   buffer = vim.api.nvim_get_current_buf() },
  })
end

vim.cmd([[
augroup markdown_grp
  autocmd!
  autocmd FileType markdown lua whichkeyMarkdown()
augroup END
]])

require('mkdnflow').setup({
  modules = {
    bib = true,
    buffers = true,
    conceal = true,
    cursor = true,
    folds = true,
    links = true,
    lists = true,
    maps = true,
    paths = true,
    tables = true
  },
  filetypes = { md = true, rmd = true, markdown = true },
  create_dirs = true,
  perspective = {
    priority = 'first',
    fallback = 'current',
    root_tell = false,
    nvim_wd_heel = true
  },
  wrap = false,
  bib = {
    default_path = nil,
    find_in_root = true
  },
  silent = false,
  links = {
    style = 'markdown',
    name_is_source = false,
    conceal = false,
    implicit_extension = nil,
    transform_implicit = false,
    transform_explicit = function(text)
      text = text:gsub(" ", "-")
      text = text:lower()
      text = os.date('%Y-%m-%d_') .. text
      return (text)
    end
  },
  to_do = {
    symbols = { ' ', '-', 'X' },
    update_parents = true,
    not_started = ' ',
    in_progress = '-',
    complete = 'X'
  },
  tables = {
    trim_whitespace = true,
    format_on_move = true,
    auto_extend_rows = false,
    auto_extend_cols = false
  },
  mappings = {
    MkdnEnter = { { 'n', 'v' }, '<CR>' },
    MkdnTab = false,
    MkdnSTab = false,
    MkdnNextLink = { 'n', '<Tab>' },
    MkdnPrevLink = { 'n', '<S-Tab>' },
    MkdnNextHeading = { 'n', ']]' },
    MkdnPrevHeading = { 'n', '[[' },
    MkdnGoBack = { 'n', '<BS>' },
    MkdnGoForward = { 'n', '<Del>' },
    MkdnFollowLink = false, -- see MkdnEnter
    MkdnDestroyLink = { 'n', '<M-CR>' },
    MkdnTagSpan = { 'v', '<M-CR>' },
    MkdnMoveSource = { 'n', '<F2>' },
    MkdnYankAnchorLink = { 'n', 'ya' },
    MkdnYankFileAnchorLink = { 'n', 'yfa' },
    MkdnIncreaseHeading = { 'n', '+' },
    MkdnDecreaseHeading = { 'n', '-' },
    MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
    MkdnNewListItem = false,
    MkdnNewListItemBelowInsert = { 'n', 'o' },
    MkdnNewListItemAboveInsert = { 'n', 'O' },
    MkdnExtendList = false,
    MkdnUpdateNumbering = { 'n', '<leader>nn' },
    MkdnTableNextCell = { 'i', '<Tab>' },
    MkdnTablePrevCell = { 'i', '<S-Tab>' },
    MkdnTableNextRow = false,
    MkdnTablePrevRow = { 'i', '<M-CR>' },
    MkdnTableNewRowBelow = { 'n', '<leader>ir' },
    MkdnTableNewRowAbove = { 'n', '<leader>iR' },
    MkdnTableNewColAfter = { 'n', '<leader>ic' },
    MkdnTableNewColBefore = { 'n', '<leader>iC' },
    MkdnFoldSection = { 'n', '<leader>f' },
    MkdnUnfoldSection = { 'n', '<leader>F' }
  }
})
