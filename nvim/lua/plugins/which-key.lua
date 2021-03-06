local wk = require("which-key")
-- As an example, we will the following mappings:
--  1. <leader>fn new file
--  2. <leader>fr show recent files
--  2. <leader>ff find files

wk.setup {
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {0, 0, 0, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
  }
}

wk.register({
  ["<leader>1"] = {
    "<cmd>lua require('bufferline').go_to_buffer(1)<cr>", "switch tab 1"
  },
  ["<leader>2"] = {
    "<cmd>lua require('bufferline').go_to_buffer(2)<cr>", "switch tab 2"
  },
  ["<leader>3"] = {
    "<cmd>lua require('bufferline').go_to_buffer(3)<cr>", "switch tab 3"
  },
  ["<leader>4"] = {
    "<cmd>lua require('bufferline').go_to_buffer(4)<cr>", "switch tab 4"
  },
  ["<leader>5"] = {
    "<cmd>lua require('bufferline').go_to_buffer(5)<cr>", "switch tab 5"
  },
  ["<leader>6"] = {
    "<cmd>lua require('bufferline').go_to_buffer(6)<cr>", "switch tab 6"
  },
  ["<leader>7"] = {
    "<cmd>lua require('bufferline').go_to_buffer(7)<cr>", "switch tab 7"
  },
  ["<leader>8"] = {
    "<cmd>lua require('bufferline').go_to_buffer(8)<cr>", "switch tab 8"
  },
  ["<leader>9"] = {
    "<cmd>lua require('bufferline').go_to_buffer(9)<cr>", "switch tab 9"
  }
})

wk.register({
  ["<f1>"] = {"<cmd>call NvimTreeProjectToggle()<cr>", "tree"},
  ["<f4>"] = {"<cmd>call CmakeBuild()<cr>", "cmake build"},
  ["K"] = {"<cmd>lua vim.lsp.buf.hover()<cr>", "lsp+hover"},
  ["gd"] = {"<cmd>Telescope lsp_definitions<cr>", "lsp+definition"},
  ["gr"] = {"<cmd>Telescope lsp_references<cr>", "lsp+references"},
  ["gf"] = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "quickfix"}

})

wk.register({
  ["<leader>f"] = {name = "+file"},

  ["<leader>ff"] = {"<cmd>Telescope file_browser<cr>", "Find File"},
  ["<leader>fd"] = {"<cmd>Telescope find_files<cr>", "Find File"},
  ["<leader>fr"] = {"<cmd>call TelescopeRecentFiles()<cr>", "Open Recent File"},
  ["<leader>fn"] = {"<cmd>enew<cr>", "New File"},
  ["<leader>fp"] = {"<cmd>call TelescopeProjectFiles()<cr>", "ProjectFiles"},
  ["<leader>fs"] = {"<cmd>w<cr>", "save file"},
  ["<leader>fb"] = {
    "<cmd>Telescope vim_bookmarks current_file<cr>", "book marks current file"
  },
  ["<leader>fB"] = {"<cmd>Telescope vim_bookmarks all<cr>", "book marks all"}
})

wk.register({
  ["<leader>b"] = {name = "+buffer"},

  ["<leader>bb"] = {"<cmd>call TelescopeBuffers()<cr>", "buffer list"},
  ["<leader>bn"] = {"<cmd>bn<cr>", "nest buffer"},
  ["<leader>bp"] = {"<cmd>bp<cr>", "prev buffer"},
  ["<leader>bk"] = {"<cmd>Bclose<cr>", "buffer kill"},
  ["<leader>bh"] = {"<cmd>Dashboard<cr>", "home"}
})

wk.register({
  ["<leader>i"] = {name = "+insert"},

  ["<leader>is"] = {"<cmd>Telescope vimsnip<cr>", "insert snippet"}
})

wk.register({
  ["<leader>w"] = {name = "+windows"},

  ["<leader>w1"] = {"<cmd>only<cr>", "close other window"},
  ["<leader>wd"] = {"<cmd>normal! <C-W>c<cr>", "delete-window"},
  ["<leader>w="] = {"<cmd>normal! <C-W>=<cr>", "balance-window"},
  ["<leader>wm"] = {"<cmd>normal! <C-W>|<cr>", "max-window"},
  ["<leader>ws"] = {"<cmd>normal! <C-W>s<cr>", "split-window-below"},
  ["<leader>wv"] = {"<cmd>normal! <C-W>v<cr>", "split-window-right"},
  ["<leader>wq"] = {"<cmd>qa<cr>", "quit"}
})

wk.register({
  ["<leader>s"] = {name = "+windows"},

  ["<leader>ss"] = {
    "<cmd>Telescope current_buffer_fuzzy_find<cr>", "symbol current buffer"
  },
  ["<leader>sp"] = {
    "<cmd>call TelescopeSymbolsCurrentProject()<cr>", "symbol project at point"
  },
  ["<leader>sP"] = {
    "<cmd>call TelescopeSymbolsCurrentProjectAtPoint()<cr>",
    "symbol project at point"
  },
  ["<leader>sl"] = {"<cmd>Telescope ctags functions<cr>", "symbol"},
  ["<leader>sh"] = {"<cmd>call InterestingWords(\"n\")<cr>", "highlight words"},
  ["<leader>sc"] = {"<cmd>call Uncolor_all_words()<cr>", "unhighlight words"}
})

wk.register({
  ["<leader>g"] = {name = "+git"},

  ["<leader>gs"] = {"<cmd>Git<cr>", "git status"},
  ["<leader>gb"] = {"<cmd>Git blame<cr>", "git blame"},
  ["<leader>gl"] = {"<cmd>Gclog<cr>", "git log"},
  ["<leader>gp"] = {"<cmd>Git push<cr>", "git push"},
  ["<leader>gP"] = {"<cmd>Git pull<cr>", "git pull"}
})

wk.register({
  ["<leader>t"] = {name = "+tools/toggle"},

  ["<leader>tc"] = {"<cmd>Telescope colorscheme<cr>", "colorscheme"},
  ["<leader>tl"] = {"<cmd>setlocal wrap!<cr>", "line wrap"},
  ["<leader>tf"] = {"<cmd>Telescope filetypes<cr>", "filetypes"},
  ["<leader>tr"] = {"<cmd>so $VIMHOME/init.vim<cr>", "refresh vimrc"}
})

wk.register({
  ["<leader>l"] = {name = "+lsp"},

  ["<leader>lr"] = {"<cmd>lua vim.lsp.buf.rename()<cr>", "rename"}
})

vim.cmd(([[
autocmd FileType cpp   lua whichkeyrCpp()
]]))
_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {
        "<cmd>lua vim.lsp.buf.formatting()<cr>",
        "formatting",
        buffer = buf
      },
      ["o"] = {"<cmd>ClangdSwitchSourceHeader<cr>", "switch cc/h", buffer = buf},
      ["d"] = {"<cmd>Dox<cr>", "doxgen", buffer = buf}
    }
  })
end

vim.cmd(([[
autocmd FileType cmake  lua whichkeyrCmake()
]]))
_G.whichkeyrCmake = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {
        "<cmd>lua vim.lsp.buf.formatting()<cr>",
        "formatting",
        buffer = buf
      }
    }
  })
end

vim.cmd(([[
autocmd FileType json,css,html,javascript,markdown,yaml,vue,typescript  lua whichkeyrPrettier()
]]))
_G.whichkeyrPrettier = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {"<cmd>FormatWrite<cr>", "formatting", buffer = buf}
    }
  })
end

local function format_before_save()
  vim.cmd('FormatWrite')
  vim.cmd('write')
end

vim.cmd(([[
autocmd FileType lua  lua whichkeyrLua()
]]))

_G.whichkeyrLua = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {format_before_save, "formatting", buffer = buf},
      ["r"] = {"<cmd>luafile %<cr>", "run current file", buffer = buf}
    }
  })
end
