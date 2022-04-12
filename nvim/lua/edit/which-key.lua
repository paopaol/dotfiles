local wk = require("which-key")

local utils = require('base.utils')
local search = require('base.search')
local bufferline = require('bufferline')
local jz = require('base.jz')
local telein = require('telescope.builtin')

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
  ["<leader><leader>"] = {command("Telescope resume"), "resume"},
  ["<leader>1"] = {function() bufferline.go_to_buffer(1) end, "buffer 1"},
  ["<leader>2"] = {function() bufferline.go_to_buffer(2) end, "buffer 2"},
  ["<leader>3"] = {function() bufferline.go_to_buffer(3) end, "buffer 3"},
  ["<leader>4"] = {function() bufferline.go_to_buffer(4) end, "buffer 4"},
  ["<leader>5"] = {function() bufferline.go_to_buffer(5) end, "buffer 5"},
  ["<leader>6"] = {function() bufferline.go_to_buffer(6) end, "buffer 6"},
  ["<leader>7"] = {function() bufferline.go_to_buffer(7) end, "buffer 7"},
  ["<leader>8"] = {function() bufferline.go_to_buffer(8) end, "buffer 8"},
  ["<leader>9"] = {function() bufferline.go_to_buffer(9) end, "buffer 9"},

  ["<tab>"] = {jz.jumpright, "right arg"},
  ["<S-tab>"] = {command("SidewaysJumpLeft"), "left arg"},
  ["<f1>"] = {search.project_tree, "tree"},
  ["<f2><f2>"] = {utils.insert_semicolon_end_of_line, "insert semicolon"},
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
    bb = {command("Telescope vim_bookmarks all"), "Bookmarks"},
    ba = {command("BookmarkAnnotate"), "Add Bookmark"},
    bd = {command("BookmarkClear"), "Clear Bookmark"},
    bD = {command("BookmarkClearAll"), "Clear All Bookmark"},
    n = {command("enew"), "New File"},
    t = {command("NvimTreeFindFileToggle"), "file tree"},
    r = {search.oldfiles, "Open Recent File"},
    f = {search.file_browser, "file browser"},
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
    b = {
      function()
        telein.buffers({cwd = rootdir(), show_all_buffers = false})
      end, "buffer list"
    }
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
    s = {
      command("Telescope current_buffer_fuzzy_find"), "symbol current buffer"
    },
    S = {search.current_buffer_symbol_at_point, "symbol current buffer"},
    i = {search.lsp_document_symbols, "symbol"},
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

    c = {
      function() telein.colorscheme({enable_preview = true}) end, "colorscheme"
    },
    l = {command("setlocal wrap!"), "line wrap"},
    f = {command("Telescope filetypes"), "filetypes"},
    r = {command("so $VIMHOME/init.vim"), "refresh vimrc"}
  },

  [",tt"] = {command("Translate"), "translate"},

  ["<leader>p"] = {
    name = "+project",

    p = {command("Telescope projects"), "projects"},
    s = {command("Telescope lsp_dynamic_workspace_symbols"), "workspace symbol"},
    e = {command("AsyncTaskEdit"), "async edit"},
    r = {search.project_oldfiles, "project recent files"},
    f = {search.project_files, "project files"},
    d = {jz.SubProjectFiles, "Find File"}
  },

  ["<leader>c"] = {
    name = "+code",

    r = {vim.lsp.buf.rename, "rename"},
    p = {search.project_live_symbols, "workspace_symbolf"},
    e = {
      function() telein.diagnostics({cwd = rootdir()}) end, "workspace_symbolf"
    }
  },
  ["<leader>i"] = {
    name = "+insert",

    s = {command("Telescope luasnip"), "snippet"}
  },

  ["<leader>r"] = {
    name = "+runner",

    r = {function() require('telescope').extensions.asynctasks.all() end, "run"},
    s = {command("AsyncStop"), "async stop"}
  }
})

wk.register({
  ["<C-x>i"] = {name = "+insert", s = {command("Telescope luasnip"), "snippet"}},
  ["<f2><f2>"] = {utils.insert_semicolon_end_of_line, "insert semicolon"}
}, {mode = "i"})

wk.register({
  ["<f2><f2>"] = {utils.insert_semicolon_end_of_line, "insert semicolon"}
}, {mode = "v"})
