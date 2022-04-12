local utils = require('base.utils')

utils.keymap('n', 'zm', ':AnyFoldActivate<CR>zM')
utils.keymap('v', 'zm', ':AnyFoldActivate<CR>zM')
utils.keymap('n', 'zr', 'zR')
utils.keymap('v', 'zr', 'zR')
