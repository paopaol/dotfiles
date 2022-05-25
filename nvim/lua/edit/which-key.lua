local wk = require("which-key")

local utils = require('base.utils')
local search = require('base.search')
local bufferline = require('bufferline')
local jz = require('base.jz')
local telein = require('telescope.builtin')
local svn = require('tools.svn')

local function rootdir() return vim.call('asyncrun#get_root', '%') end

local function command(cmd) return function() vim.cmd(cmd) end end

wk.setup {
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 } -- extra window padding [top, right, bottom, left]
  }
}

local reg_keymap = function(map, modes, leader)
  for _, mode in ipairs(modes) do
    for key, value in pairs(map) do
      wk.register({
        [leader] = { [key] = value },
      }, { mode = mode })
    end
  end
end


wk.register({
  ["<tab>"] = { jz.jumpright, "right arg" },
  ["<S-tab>"] = { command("SidewaysJumpLeft"), "left arg" },
  ["<f1>"] = { search.project_tree, "tree" },
  ["<f2><f2>"] = { utils.insert_semicolon_end_of_line, "insert semicolon" },
  ["<f3>"] = { command("AerialToggle"), "symbols list" },
  ["<f4>"] = { command("TroubleToggle"), "diagnostic list" },
  ["<C-S-k>"] = { function()
    local opts = {
      focusable = true,
      border = 'rounded',
      prefix = '',
    }
    local _, winid = vim.diagnostic.open_float(nil, opts)
    if winid and vim.api.nvim_win_is_valid(winid) then
      vim.api.nvim_win_set_height(winid, 5);
      vim.api.nvim_win_set_width(winid, 60);
    end
  end, "show diagnostics" },
  ["K"] = { vim.lsp.buf.hover, "lsp+hover" },
})

-- files
reg_keymap({
  name = "+file",

  F = { search.project_files, "project files" },
  H = { command("silent !dolphin $HOME &"), "home" },
  bD = { command("BookmarkClearAll"), "Clear All Bookmark" },
  ba = { command("BookmarkAnnotate"), "Add Bookmark" },
  bb = { command("Telescope vim_bookmarks all"), "Bookmarks" },
  bd = { command("BookmarkClear"), "Clear Bookmark" },
  f = { search.file_browser, "file browser" },
  n = { command("enew"), "New File" },
  o = { search.open_with_defualt, "externl open" },
  q = { utils.open_current_file_use_qtcreator, "open in qtcreator" },
  r = { search.oldfiles, "Open Recent File" },
  t = { command("NvimTreeFindFileToggle"), "file tree" },
}, { "n" }, "<leader>f"
)


-- debug
reg_keymap({
  name = "+debug",

  i = { command("VimspectorDebugInfo"), "print info" },
  l = { command("VimspectorToggleLog"), "toggle log" },
  o = { command("VimspectorShowOutput"), "show output" },
  s = { command("VimspectorReset"), "stop/reset" },
  w = { command("VimspectorWatch"), "watch" }
}, { "n" }, "<leader>d"
)

-- open
reg_keymap({
  name = "+open",

  ["2"] = { utils.open200, "200" },
  d = { search.exploer_dir_current, "externl open current dir" },
  p = { search.exploer_dir_project, "externl open project dir" },
}, { "n" }, "<leader>o"
)

-- buffer
reg_keymap({
  name = "+buffer",

  d = { jz.close_current_buffer, "nest buffer" },
  k = { jz.close_current_buffer, "buffer kill" },
  n = { command("BufSurfForward"), "nest buffer" },
  p = { command("BufSurfBack"), "prev buffer" },
  K = { command("BDelete other"), "buffer kill" },
  h = { command("Alpha"), "home" },
  b = {
    search.buffers, "buffer list"
  },
  B = {
    search.project_buffers, "project buffers"
  }
}, { "n" }, "<leader>b"
)

-- windows
reg_keymap({
  name = "+windows",

  ["1"] = { command("only"), "close other window" },
  ["="] = { command("wincmd ="), "balance-window" },
  d = { command("wincmd c"), "delete-window" },
  m = { command("wincmd |"), "max-window" },
  n = { command("tabnext"), "next tab" },
  p = { command("tabprevious"), "previous tab" },
  q = { command("qa"), "quit" },
  s = { command("wincmd s"), "split-window-below" },
  t = { command("tabnew"), "new tab" },
  v = { command("wincmd v"), "split-window-right" },
  w = { command("tabnew"), "new tab" },
}, { "n" }, "<leader>w"
)

-- serach/symbol
reg_keymap({
  name = "+search/symbol",

  h = { command("Interestingwords --toggle"), "highlight words" },
  s = {
    search.search_current_buffer, "symbol current buffer"
  },
  S = { search.current_buffer_symbol_at_point, "symbol current buffer" },
  i = { search.lsp_document_symbols, "symbol" },
  p = { search.project_current_symbols, "symbol project at point" },
  P = { search.project_symbol_at_point, "symbol project at point" },
  d = { search.directory_live_symbol, "symbol current directory" },
  c = { utils.uncolor_all_words, "unhighlight words" },
}, { "n" }, "<leader>s"
)

-- git
reg_keymap({
  name = "+git",

  P = { command("Git pull"), "git pull" },
  b = { command("Git blame"), "git blame" },
  g = { command("Git"), "git status" },
  l = { command("Gclog"), "git log" },
  p = { command("Git push"), "git push" },
}, { "n" }, "<leader>g"
)

-- tools
reg_keymap({
  name = "+tools/toggle",

  c = { command("Telescope themes"), "colorscheme" },
  f = { command("Telescope filetypes"), "filetypes" },
  l = { command("setlocal wrap!"), "line wrap" },
  r = { command("so $VIMHOME/init.vim"), "refresh vimrc" }
}, { "n" }, "<leader>t"
)

-- project
reg_keymap({
  name = "+project",

  b = { search.project_buffers, "Project buffers" },
  d = { jz.SubProjectFiles, "Find File" },
  e = { command("AsyncTaskEdit"), "async edit" },
  f = { search.project_files, "project files" },
  p = { command("Telescope projects"), "projects" },
  r = { search.project_oldfiles, "project recent files" },
  s = { command("Telescope lsp_dynamic_workspace_symbols"), "workspace symbol" },
}, { "n" }, "<leader>p"
)

-- code
reg_keymap({
  name = "+code",

  r = { require('renamer').rename, "rename" },
  c = { search.lsp_calltree, "calltree" },
  p = { search.project_live_symbols, "workspace_symbolf" },
  e = {
    function() telein.diagnostics({ cwd = rootdir(), bufnr = 0 }) end, "workspace diagnostics"
  },
  E = {
    function() telein.diagnostics({ cwd = rootdir() }) end, "workspace diagnostics"
  }
}, { "n" }, "<leader>c"
)

reg_keymap({
  name = "+insert",

  s = { command("Telescope luasnip disable_ft=true"), "snippet" }
}, { "n" }, "<leader>i"
)


reg_keymap({
  name = "+runner",

  r = { function() require('telescope').extensions.asynctasks.all() end, "run" },
  s = { command("AsyncStop"), "async stop" }
}, { "n" }, "<leader>r"
)


reg_keymap({
  name = "+svn",

  d = { svn.svn_diff_current_buf, "svn diff current" },
  l = { svn.svn_log_current_buf, "svn log current" },
  L = { svn.svn_log_project, "svn log project" },
  b = { svn.svn_blame, "svn blame current" },
  u = { svn.svn_update, "svn update" },
  c = { svn.svn_commit, "svn commit" },
  a = { svn.svn_add_current_file, "svn add current file" },
}, { "n" }, "<leader>v"
)


reg_keymap({
  name = "+all-major",

  d = { command('Dox'), "anotaion func" },
  D = { command('Neogen class'), "anotaion class" },
  f = { command('Neogen file'), "anotaion file" },
  c = { search.lsp_calltree, "calltree" },
  p = { search.project_live_symbols, "workspace_symbolf" },
  e = {
    function() telein.diagnostics({ cwd = rootdir(), bufnr = 0 }) end, "document diagnostics"
  },
  ["tt"] = { command("Translate"), "translate" },
}, { "n" }, ","
)

reg_keymap({
  name = "+all-major",

  ["<f2>"] = { utils.insert_semicolon_end_of_line, "insert semicolon" },
}, { "n", "i" }, "<f2>"
)


reg_keymap({
  name = "+insert",

  s = { command("Telescope luasnip disable_ft=true"), "snippet" }
}, { "i" }, "<C-x>i"
)

reg_keymap({
  name = "+all",

  ["<leader>"] = { command("Telescope resume"), "resume" },
  ["1"] = { function() bufferline.go_to_buffer(1, true) end, "buffer 1" },
  ["2"] = { function() bufferline.go_to_buffer(2, true) end, "buffer 2" },
  ["3"] = { function() bufferline.go_to_buffer(3, true) end, "buffer 3" },
  ["4"] = { function() bufferline.go_to_buffer(4, true) end, "buffer 4" },
  ["5"] = { function() bufferline.go_to_buffer(5, true) end, "buffer 5" },
  ["6"] = { function() bufferline.go_to_buffer(6, true) end, "buffer 6" },
  ["7"] = { function() bufferline.go_to_buffer(7, true) end, "buffer 7" },
  ["8"] = { function() bufferline.go_to_buffer(8, true) end, "buffer 8" },
  ["9"] = { function() bufferline.go_to_buffer(9, true) end, "buffer 9" },

}, { "n" }, "<leader>"
)

reg_keymap({
  name = "+goto",

  ["d"] = { vim.lsp.buf.declaration, "lsp+definition" },
  ["i"] = { vim.lsp.buf.definition, "lsp+definition" },
  ["r"] = { search.project_lsp_ref, "lsp+references" },
  ["f"] = { vim.lsp.buf.code_action, "quickfix" },
  ["y"] = { ___gdc, "comment and yank" },
}, { "n" }, "g"
)
