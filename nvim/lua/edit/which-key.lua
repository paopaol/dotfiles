local wk = require("which-key")

local utils = require('base.utils')
local search = require('base.search')
local bufferline = require('bufferline')
local fzflua = require('fzf-lua')
local jz = require('base.jz')

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
  ["<leader>9"] = {function() bufferline.go_to_buffer(9) end, "buffer 9"},

  ["<f1>"] = {search.project_tree, "tree"},
  ["<f3>"] = {command("AerialToggle"), "symbols list"},
  ["K"] = {vim.lsp.buf.hover, "lsp+hover"},
  ["gd"] = {vim.lsp.buf.declaration, "lsp+definition"},
  ["gi"] = {vim.lsp.buf.definition, "lsp+definition"},
  ["gr"] = {search.project_lsp_ref, "lsp+references"},
  ["gf"] = {vim.lsp.buf.code_action, "quickfix"},

  ["<leader>d"] = {
    name = "+debug",

    s = {command("VimspectorReset"), "stop/reset"},
    i = {command("VimspectorDebugInfo"), "print info"},
    o = {command("VimspectorShowOutput"), "show output"},
    l = {command("VimspectorToggleLog"), "toggle log"},
    w = {command("VimspectorWatch"), "watch"}
  },
  ["<leader>f"] = {
    name = "+file",

    ["2"] = {command("silent !dolphin smb://192.168.0.200 &"), "200"},
    H = {command("silent !dolphin $HOME &"), "home"},
    bb = {command("FzfVimBookmarkes"), "Bookmarks"},
    ba = {command("BookmarkAnnotate"), "Add Bookmark"},
    bd = {command("BookmarkClear"), "Clear Bookmark"},
    bD = {command("BookmarkClearAll"), "Clear All Bookmark"},
    n = {command("enew"), "New File"},
    t = {command("NERDTreeFind"), "file types"},
    r = {command("FzfRecentFiles"), "Open Recent File"},
    f = {command("FzfFilesExplorer"), "Find File"},
    d = {jz.SubProjectFiles, "Find File"},
    p = {search.project_files, "ProjectFiles"},
    q = {utils.open_current_file_use_qtcreator, "open in qtcreator"}
  },
  ["<leader>b"] = {
    name = "+buffer",

    d = {jz.close_current_buffer, "nest buffer"},
    k = {jz.close_current_buffer, "buffer kill"},
    n = {command("BufSurfForward"), "nest buffer"},
    p = {command("BufSurfBack"), "prev buffer"},
    K = {command("BDelete other"), "buffer kill"},
    h = {command("Dashboard"), "home"},
    b = {function() fzflua.buffers({cwd = rootdir()}) end, "buffer list"}
  },
  ["<leader>i"] = {
    name = "+insert",

    s = {command("FzfUSnippet"), "insert snippet"}
  },

  ["<leader>w"] = {
    name = "+windows",

    ["1"] = {command("only"), "close other window"},
    ["="] = {command("wincmd ="), "balance-window"},
    d = {command("wincmd c"), "delete-window"},
    m = {command("wincmd |"), "max-window"},
    s = {command("wincmd s"), "split-window-below"},
    v = {command("wincmd v"), "split-window-right"},
    t = {command("tabnew"), "new tab"},
    w = {command("tabnew"), "new tab"},
    p = {command("tabprevious"), "previous tab"},
    n = {command("tabnext"), "next tab"},
    q = {command("qa"), "quit"}
  },

  ["<leader>s"] = {
    name = "+search/symbol",

    h = {"<cmd>call InterestingWords('n')<cr>", "highlight words"},
    s = {command("FzfLua blines"), "symbol current buffer"},
    S = {command("FzfLua grep_cword"), "symbol current buffer"},
    i = {command("FzfLua lsp_document_symbols"), "symbol"},
    p = {search.project_current_symbols, "symbol project at point"},
    P = {search.project_symbol_at_point, "symbol project at point"},
    d = {search.directory_live_symbol, "symbol current directory"},
    c = {utils.uncolor_all_words, "unhighlight words"}
  },
  ["<leader>g"] = {
    name = "+git",

    b = {command("Git blame"), "git blame"},
    g = {command("Git"), "git status"},
    l = {command("Gclog"), "git log"},
    p = {command("Git push"), "git push"},
    P = {command("Git pull"), "git pull"}
  },

  ["<leader>t"] = {
    name = "+tools/toggle",

    c = {command("FzfLua colorschemes"), "colorscheme"},
    l = {command("setlocal wrap!"), "line wrap"},
    f = {command("FzfLua filetypes"), "filetypes"},
    r = {command("so $VIMHOME/init.vim"), "refresh vimrc"}
  },

  [",tt"] = {command("Translate"), "translate"},

  ["<leader>p"] = {
    name = "+project",

    p = {command("FzfProjects"), "projects"},
    s = {command("FzfLua lsp_workspace_symbols"), "workspace symbol"},
    e = {command("AsyncTaskEdit"), "async edit"},
    S = {command("AsyncStop"), "async stop"}
  },

  ["<leader>c"] = {
    name = "+code",

    r = {vim.lsp.buf.rename, "rename"},
    p = {search.project_live_symbols, "workspace_symbolf"},
    e = {
      function() fzflua.lsp_document_diagnostics({cwd = rootdir()}) end,
      "workspace_symbolf"
    }
  },
  ["<leader>r"] = {command("FzfAsyncTask"), "runner"}

})
