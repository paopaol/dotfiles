local utils = require('base.utils')

utils.keymap('n', 'zm', ':AnyFoldActivate<CR>zM')
utils.keymap('v', 'zm', ':AnyFoldActivate<CR>zM')
utils.keymap('n', 'zr', 'zR')
utils.keymap('v', 'zr', 'zR')
--
--
-- local keymap_amend = require('keymap-amend')
-- local mapping = require('pretty-fold.preview').mapping
-- keymap_amend('n', 'h', mapping.show_close_preview_open_fold)
-- keymap_amend('n', 'l', mapping.close_preview_open_fold)
-- keymap_amend('n', 'zo', mapping.close_preview)
-- keymap_amend('n', 'zO', mapping.close_preview)
-- keymap_amend('n', 'zc', mapping.close_preview_without_defer)

-- local keymap = vim.keymap
-- keymap.amend = require('keymap-amend')
-- local map = require('fold-preview').mapping
--
-- keymap.amend('n', 'zr', map.show_close_preview_open_fold)
-- -- keymap.amend('n', 'l', map.close_preview_open_fold)
-- keymap.amend('n', 'zo', map.close_preview)
-- keymap.amend('n', 'zO', map.close_preview)
-- keymap.amend('n', 'zc', map.close_preview_without_defer)
-- keymap.amend('n', 'zR', map.close_preview)
-- keymap.amend('n', 'zM', map.close_preview_without_defer)
