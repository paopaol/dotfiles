local wk = require("which-key")

wk.setup {
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {0, 0, 0, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
  }
}

wk.register({
  ["<leader><leader>"] = {"<cmd>call ProjectFiles()<cr>", "projectile"},
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
  ["<f1>"] = {"<cmd>NERDTreeToggleVCS<cr>", "tree"},
  ["<f4>"] = {"<cmd>call CmakeBuild()<cr>", "cmake build"},
  ["K"] = {"<cmd>lua vim.lsp.buf.hover()<cr>", "lsp+hover"},
  ["gd"] = {"<cmd>lua vim.lsp.buf.declaration()<cr>", "lsp+definition"},
  ["gi"] = {"<cmd>lua vim.lsp.buf.definition()<cr>", "lsp+definition"},
  ["gr"] = {"<cmd>call LspRefes()<cr>", "lsp+references"},
  ["gf"] = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "quickfix"}

})

wk.register({
  ["<leader>d"] = {name = "+debug"},

  ["<leader>ds"] = {"<cmd>VimspectorReset<cr>", "stop/reset"},
  ["<leader>di"] = {"<cmd>:VimspectorDebugInfo<cr>", "print info"},
  ["<leader>do"] = {"<cmd>VimspectorShowOutput<cr>", "show output"},
  ["<leader>dl"] = {"<cmd>:VimspectorToggleLog<cr>", "toggle log"},
  ["<leader>dw"] = {"<cmd>VimspectorWatch<cr>", "watch"},
  ["<leader>de"] = {"<cmd>call StartDebug()<cr>", "start/edit"}
})

wk.register({
  ["<leader>f"] = {name = "+file"},

  ["<leader>fbb"] = {"<cmd>BookmarkShowAll<cr>", "Bookmarks"},
  ["<leader>fba"] = {"<cmd>BookmarkAnnotate<cr>", "Add Bookmark"},
  ["<leader>fbd"] = {"<cmd>BookmarkClear<cr>", "Clear Bookmark"},
  ["<leader>fbD"] = {"<cmd>BookmarkClearAll<cr>", "Clear All Bookmark"},
  ["<leader>ff"] = {"<cmd>Telescope file_browser<cr>", "Find File"},
  ["<leader>fd"] = {"<cmd>call SubProjectFiles()<cr>", "Find File"},
  ["<leader>fr"] = {"<cmd>FzfRecentFiles<cr>", "Open Recent File"},
  ["<leader>fn"] = {"<cmd>enew<cr>", "New File"},
  ["<leader>fp"] = {"<cmd>call ProjectFiles()<cr>", "ProjectFiles"},
  ["<leader>ft"] = {"<cmd>NERDTreeFind<cr>", "file types"}
})

wk.register({
  ["<leader>b"] = {name = "+buffer"},

  ["<leader>bb"] = {
    "<cmd>lua require('fzf-lua').buffers({ cwd = vim.call('asyncrun#get_root', '%')})<cr>",
    "buffer list"
  },
  ["<leader>bd"] = {
    "<cmd>lua require('plugins.jz').close_current_buffer()<cr>", "nest buffer"
  },
  ["<leader>bn"] = {"<cmd>BufSurfForward<cr>", "nest buffer"},
  ["<leader>bp"] = {"<cmd>BufSurfBack<cr>", "prev buffer"},
  ["<leader>bk"] = {
    "<cmd>lua require('plugins.jz').close_current_buffer()<cr>", "buffer kill"
  },
  ["<leader>bK"] = {"<cmd>BDelete other<cr>", "buffer kill"},
  ["<leader>bh"] = {"<cmd>Dashboard<cr>", "home"}
})

wk.register({
  ["<leader>i"] = {name = "+insert"},

  ["<leader>is"] = {"<cmd>FzfUSnippet<cr>", "insert snippet"}
})

wk.register({
  ["<leader>w"] = {name = "+windows"},

  ["<leader>w1"] = {"<cmd>only<cr>", "close other window"},
  ["<leader>wd"] = {"<cmd>normal! <C-W>c<cr>", "delete-window"},
  ["<leader>w="] = {"<cmd>normal! <C-W>=<cr>", "balance-window"},
  ["<leader>wm"] = {"<cmd>normal! <C-W>|<cr>", "max-window"},
  ["<leader>ws"] = {"<cmd>normal! <C-W>s<cr>", "split-window-below"},
  ["<leader>wv"] = {"<cmd>normal! <C-W>v<cr>", "split-window-right"},
  ["<leader>wt"] = {"<cmd>tabnew<cr>", "new tab"},
  ["<leader>ww"] = {"<cmd>tabnew<cr>", "new tab"},
  ["<leader>wp"] = {"<cmd>tabprevious<cr>", "previous tab"},
  ["<leader>wn"] = {"<cmd>tabnext<cr>", "next tab"},
  ["<leader>wq"] = {"<cmd>qa<cr>", "quit"}
})

wk.register({
  ["<leader>sS"] = {"<cmd>FzfLua grep_cword<cr>", "symbol current buffer"}
}, {mode = "v"})

wk.register({
  ["<leader>s"] = {name = "+search/symbol"},

  ["<leader>sd"] = {
    "<cmd>call SymbolsCurrentDirectory()<cr>", "symbol current directory"
  },
  ["<leader>ss"] = {"<cmd>FzfLua blines<cr>", "symbol current buffer"},
  ["<leader>sS"] = {"<cmd>FzfLua grep_cword<cr>", "symbol current buffer"},
  ["<leader>sp"] = {
    "<cmd>call SymbolsCurrentProject()<cr>", "symbol project at point"
  },
  ["<leader>sP"] = {
    "<cmd>call SymbolsCurrentProjectAtPoint()<cr>", "symbol project at point"
  },
  ["<leader>si"] = {"<cmd>FzfLua lsp_document_symbols<cr>", "symbol"},
  ["<leader>sh"] = {"<cmd>call InterestingWords(\"n\")<cr>", "highlight words"},
  ["<leader>sc"] = {"<cmd>call Uncolor_all_words()<cr>", "unhighlight words"}
})

wk.register({
  ["<leader>g"] = {name = "+git"},

  ["<leader>gb"] = {"<cmd>Git blame<cr>", "git blame"},
  ["<leader>gg"] = {"<cmd>Neogit<cr>", "git status"},
  ["<leader>gl"] = {"<cmd>Gclog<cr>", "git log"},
  ["<leader>gp"] = {"<cmd>Git push<cr>", "git push"},
  ["<leader>gP"] = {"<cmd>Git pull<cr>", "git pull"}
})

wk.register({
  ["<leader>t"] = {name = "+tools/toggle"},

  ["<leader>tc"] = {"<cmd>FzfLua colorschemes<cr>", "colorscheme"},
  ["<leader>tl"] = {"<cmd>setlocal wrap!<cr>", "line wrap"},
  ["<leader>tf"] = {"<cmd>FzfLua filetypes<cr>", "filetypes"},
  ["<leader>tr"] = {"<cmd>so $VIMHOME/init.vim<cr>", "refresh vimrc"}
})

wk.register({
  ["<leader>p"] = {name = "+project"},

  ["<leader>ps"] = {"<cmd>FzfLua lsp_workspace_symbols<cr>", "workspace symbol"}
})

wk.register({
  ["<leader>c"] = {name = "+code"},

  ["<leader>cr"] = {"<cmd>lua vim.lsp.buf.rename()<cr>", "rename"},
  ["<leader>cp"] = {"<cmd>call ProjectLiveSymbols()<cr>", "workspace_symbolf"},
  ["<leader>ce"] = {
    "<cmd>lua require('fzf-lua').lsp_document_diagnostics({ cwd = vim.call('asyncrun#get_root', '%')})<cr>",
    "workspace_symbolf"
  }
})

wk.register({["<leader>r"] = {"<cmd>FzfAsyncTask<cr>", "runner"}})

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
      ["d"] = {"<cmd>Dox<cr>", "doxgen", buffer = buf},
      ["y"] = {"<cmd>CopyCppMethod<cr>", "copy cpp method", buffer = buf},
      ["p"] = {"<cmd>PasteCppMethod<cr>", "paste cpp method", buffer = buf}
    }
  })
end

vim.cmd(([[
autocmd FileType cmake,go  lua whichkeyrCmake()
autocmd FileType cmake,go  set tabstop=2
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
autocmd FileType json,css,html,javascript,markdown,yaml,vue,typescript lua whichkeyrPrettier()
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

vim.cmd(([[
autocmd FileType xml,html  lua whichkeyrXml()
]]))

_G.whichkeyrXml = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('set shiftwidth=1')

  wk.register({
    ["<tab>"] = {"<cmd>normal! za<cr>", "expand", buffer = buf},
    ["<localleader>"] = {
      name = "major",
      [","] = {"<cmd>Autoformat<cr>", "formatting", buffer = buf}
    }
  })
end
