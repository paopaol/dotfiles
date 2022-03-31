local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  highlight = {enable = true},
  textobjects = {enable = true},
  indent = {enable = false},
  autotag = {enable = true},
  ensure_installed = {'bash', 'css', 'html', 'rust', 'toml', 'yaml', 'cpp', 'c'}
})

require'treesitter-context'.setup {enable = true, throttle = true}
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg",
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main"
  }
}
