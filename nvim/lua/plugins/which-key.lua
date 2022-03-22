local wk = require("which-key")

local utils = require('utils')
local search = require('search')
local bufferline = require('bufferline')
local telescope = require('telescope')
local fzflua = require('fzf-lua')
local jz = require('plugins.jz')

local function rootdir() return vim.call('asyncrun#get_root', '%') end

local function command(cmd) return function() vim.cmd(cmd) end end

wk.setup {
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = {0, 0, 0, 0}, -- extra window margin [top, right, bottom, left]
    padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
  }
}

wk.register({
  ["<leader><leader>"] = {search.project_files, "projectile"},
  ["<leader>1"] = {function() bufferline.go_to_buffer(1) end, "buffer 1"},
  ["<leader>2"] = {function() bufferline.go_to_buffer(2) end, "buffer 2"},
  ["<leader>3"] = {function() bufferline.go_to_buffer(3) end, "buffer 3"},
  ["<leader>4"] = {function() bufferline.go_to_buffer(4) end, "buffer 4"},
  ["<leader>5"] = {function() bufferline.go_to_buffer(5) end, "buffer 5"},
  ["<leader>6"] = {function() bufferline.go_to_buffer(6) end, "buffer 6"},
  ["<leader>7"] = {function() bufferline.go_to_buffer(7) end, "buffer 7"},
  ["<leader>8"] = {function() bufferline.go_to_buffer(8) end, "buffer 8"},
  ["<leader>9"] = {function() bufferline.go_to_buffer(9) end, "buffer 9"}
})

wk.register({
  ["<f1>"] = {search.project_tree, "tree"},
  ["<f4>"] = {vim.fn.CmakeBuild, "cmake build"},
  ["K"] = {vim.lsp.buf.hover, "lsp+hover"},
  ["gd"] = {vim.lsp.buf.declaration, "lsp+definition"},
  ["gi"] = {vim.lsp.buf.definition, "lsp+definition"},
  ["gr"] = {search.project_lsp_ref, "lsp+references"},
  ["gf"] = {vim.lsp.buf.code_action, "quickfix"}
})

wk.register({
  ["<leader>d"] = {name = "+debug"},

  ["<leader>ds"] = {command("VimspectorReset"), "stop/reset"},
  ["<leader>di"] = {command("VimspectorDebugInfo"), "print info"},
  ["<leader>do"] = {command("VimspectorShowOutput"), "show output"},
  ["<leader>dl"] = {command("VimspectorToggleLog"), "toggle log"},
  ["<leader>dw"] = {command("VimspectorWatch"), "watch"},
  ["<leader>de"] = {vim.fn.StartDebug, "start/edit"}
})

wk.register({
  ["<leader>f"] = {name = "+file"},

  ["<leader>fbb"] = {command("FzfVimBookmarkes"), "Bookmarks"},
  ["<leader>fba"] = {command("BookmarkAnnotate"), "Add Bookmark"},
  ["<leader>fbd"] = {command("BookmarkClear"), "Clear Bookmark"},
  ["<leader>fbD"] = {command("BookmarkClearAll"), "Clear All Bookmark"},
  ["<leader>fn"] = {command("enew"), "New File"},
  ["<leader>ft"] = {command("NERDTreeFind"), "file types"},
  ["<leader>fr"] = {command("FzfRecentFiles"), "Open Recent File"},
  ["<leader>ff"] = {telescope.extensions.file_browser.file_browser, "Find File"},
  ["<leader>fd"] = {jz.SubProjectFiles, "Find File"},
  ["<leader>fp"] = {search.project_files, "ProjectFiles"},
  ["<leader>fq"] = {utils.open_current_file_use_qtcreator, "open in qtcreator"}
})

wk.register({
  ["<leader>b"] = {name = "+buffer"},

  ["<leader>bd"] = {jz.close_current_buffer, "nest buffer"},
  ["<leader>bk"] = {jz.close_current_buffer, "buffer kill"},
  ["<leader>bn"] = {command("BufSurfForward"), "nest buffer"},
  ["<leader>bp"] = {command("BufSurfBack"), "prev buffer"},
  ["<leader>bK"] = {command("BDelete other"), "buffer kill"},
  ["<leader>bh"] = {command("Dashboard"), "home"},
  ["<leader>bb"] = {
    function() fzflua.buffers({cwd = rootdir()}) end, "buffer list"
  }
})

wk.register({
  ["<leader>i"] = {name = "+insert"},

  ["<leader>is"] = {command("FzfUSnippet"), "insert snippet"}
})

wk.register({
  ["<leader>w"] = {name = "+windows"},

  ["<leader>w1"] = {command("only"), "close other window"},
  ["<leader>wd"] = {command("wincmd c"), "delete-window"},
  ["<leader>w="] = {command("wincmd ="), "balance-window"},
  ["<leader>wm"] = {command("wincmd |"), "max-window"},
  ["<leader>ws"] = {command("wincmd s"), "split-window-below"},
  ["<leader>wv"] = {command("wincmd v"), "split-window-right"},
  ["<leader>wt"] = {command("tabnew"), "new tab"},
  ["<leader>ww"] = {command("tabnew"), "new tab"},
  ["<leader>wp"] = {command("tabprevious"), "previous tab"},
  ["<leader>wn"] = {command("tabnext"), "next tab"},
  ["<leader>wq"] = {command("qa"), "quit"}
})

wk.register({
  ["<leader>sS"] = {command("FzfLua grep_cword"), "symbol current buffer"},
  ["<leader>tt"] = {command("Translate"), "translate"},
  [",,"] = {vim.lsp.buf.range_formatting, "formatting"}
}, {mode = "v"})

wk.register({
  ["<leader>s"] = {name = "+search/symbol"},

  ["<leader>sf"] = {
    function() telescope.builtin.live_grep({cwd = rootdir()}) end, "Find File"
  },
  ["<leader>sh"] = {"<cmd>call InterestingWords('n')<cr>", "highlight words"},
  ["<leader>ss"] = {command("FzfLua blines"), "symbol current buffer"},
  ["<leader>sS"] = {command("FzfLua grep_cword"), "symbol current buffer"},
  ["<leader>si"] = {command("FzfLua lsp_document_symbols"), "symbol"},
  ["<leader>sp"] = {search.project_current_symbols, "symbol project at point"},
  ["<leader>sP"] = {search.project_symbol_at_point, "symbol project at point"},
  ["<leader>sd"] = {search.directory_live_symbol, "symbol current directory"},
  ["<leader>sc"] = {vim.fn.Uncolor_all_words, "unhighlight words"}
})

wk.register({
  ["<leader>g"] = {name = "+git"},

  ["<leader>gb"] = {command("Git blame"), "git blame"},
  ["<leader>gg"] = {command("Neogit"), "git status"},
  ["<leader>gl"] = {command("Gclog"), "git log"},
  ["<leader>gp"] = {command("Git push"), "git push"},
  ["<leader>gP"] = {command("Git pull"), "git pull"}
})

wk.register({
  ["<leader>t"] = {name = "+tools/toggle"},

  ["<leader>tt"] = {command("Translate"), "translate"},
  ["<leader>tc"] = {command("FzfLua colorschemes"), "colorscheme"},
  ["<leader>tl"] = {command("setlocal wrap!"), "line wrap"},
  ["<leader>tf"] = {command("FzfLua filetypes"), "filetypes"},
  ["<leader>tr"] = {command("so $VIMHOME/init.vim"), "refresh vimrc"}
})

wk.register({
  ["<leader>p"] = {name = "+project"},

  ["<leader>ps"] = {command("FzfLua lsp_workspace_symbols"), "workspace symbol"},
  ["<leader>pe"] = {command("AsyncTaskEdit"), "async edit"},
  ["<leader>pS"] = {command("AsyncStop"), "async stop"}
})

wk.register({
  ["<leader>c"] = {name = "+code"},

  ["<leader>cr"] = {vim.lsp.buf.rename, "rename"},
  ["<leader>cp"] = {search.project_live_symbols, "workspace_symbolf"},
  ["<leader>ce"] = {
    function() fzflua.lsp_document_diagnostics({cwd = rootdir()}) end,
    "workspace_symbolf"
  }
})

wk.register({["<leader>r"] = {command("FzfAsyncTask"), "runner"}})

vim.cmd(([[
autocmd FileType cpp   lua whichkeyrCpp()
]]))
_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {vim.lsp.buf.formatting, "formatting", buffer = buf},
      ["o"] = {command("ClangdSwitchSourceHeader"), "switch cc/h", buffer = buf},
      ["d"] = {command("Dox"), "doxgen", buffer = buf},
      ["y"] = {command("CopyCppMethod"), "copy cpp method", buffer = buf},
      ["p"] = {command("PasteCppMethod"), "paste cpp method", buffer = buf}
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
      [","] = {vim.lsp.buf.formatting, "formatting", buffer = buf}
    }
  })
end

vim.cmd(
    ([[ autocmd FileType json,css,html,javascript,markdown,yaml,vue,typescript lua whichkeyrPrettier() ]]))
_G.whichkeyrPrettier = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {command("FormatWrite"), "formatting", buffer = buf}
    }
  })
end

local function format_before_save()
  vim.cmd('FormatWrite')
  vim.cmd('write')
end

vim.cmd(([[ autocmd FileType lua  lua whichkeyrLua() ]]))
_G.whichkeyrLua = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {format_before_save, "formatting", buffer = buf},
      ["r"] = {command("luafile %"), "run current file", buffer = buf}
    }
  })
end

vim.cmd(([[ autocmd FileType xml,html  lua whichkeyrXml() ]]))

_G.whichkeyrXml = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('set shiftwidth=1')

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = {command("Autoformat"), "formatting", buffer = buf}
    },
    ["<tab>"] = {command("normal! za"), "expand", buffer = buf}
  })
end
