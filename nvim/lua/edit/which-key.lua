local function cppman()
  vim.ui.input({ prompt = "Enter c++ symbol: " }, function(input)
    if not input then
      return
    end

    local trim = function(input)
      return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
    end
    input = trim(input)

    if input == "" then
      return
    end

    local cmd = string.format("cppman %s", input)
    local lazygit = Terminal:new({
      cmd = cmd,
      direction = "float",
      float_opts = {
        border = "double",
      }
    })
    lazygit:toggle()
  end)
end

local function rootdir()
  return vim.call("asyncrun#get_root", "%")
end

local function command(cmd)
  return function()
    pcall(vim.cmd, cmd)
  end
end

local qf_next = function()
  local ok = pcall(vim.cmd, [[cn]])
  if ok then
    vim.cmd([[normal zz]])
  end
end

local qf_prev = function()
  local ok = pcall(vim.cmd, [[cp]])
  if ok then
    vim.cmd([[normal zz]])
  end
end

local show_diagnostic = function()
  local opts = {
    focusable = true,
    border = "rounded",
    prefix = "",
  }
  local _, winid = vim.diagnostic.open_float(nil, opts)
  if winid and vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_win_set_height(winid, 15)
    vim.api.nvim_win_set_width(winid, 100)
  end
end

local task_run = function()
  pcall(vim.cmd, string.format("cd %s/build", rootdir()))
  require("telescope").extensions.asynctasks.all()
end

local lsp_definitions_vsplit = function()
  vim.cmd([[wincmd v]])
  vim.cmd([[Telescope lsp_definitions]])
end

local lsp_definitions_split = function()
  vim.cmd([[wincmd s]])
  vim.cmd([[Telescope lsp_definitions]])
end

return {
  {
    "folke/which-key.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
      local utils = require("base.utils")
      local search = require("base.search")
      local bufferline = require("bufferline")
      local jz = require("base.jz")
      local telein = require("telescope.builtin")
      local svn = require("tools.svn")
      local hexview = require("edit.hex-view")
      local Terminal = require("toggleterm.terminal").Terminal
      local wk = require("which-key")
      wk.setup({
        win = { no_overlap = false, padding = { 1, 2 }, title = true, title_pos = "center", zindex = 1000, bo = {}, wo = {}, },
        plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = false,
        },
        show_keys = true,
        show_help = true,
      })


      wk.add({
        -- ["<tab>"] = { jz.jumpright, "right arg" },
        -- ["<S-tab>"] = { command("SidewaysJumpLeft"), "left arg" },
        { "<f1>",     search.project_tree,                desc = "tree",             mode = "n" },
        { "<f2><f2>", utils.insert_semicolon_end_of_line, desc = "insert semicolon", mode = { "n", "i" } },
        { "<f3>",     qf_prev,                            desc = "prev item",        mode = "n" },
        { "<f4>",     qf_next,                            desc = "next item",        mode = "n" },
        { "<A-,>",    show_diagnostic,                    desc = "show diagnostic",  mode = "n" },
        { "<A-\\>",   command("ToggleTermToggleAll"),     desc = "terminal",         mode = { "n", "i", "t" } }
      })




      -- files
      wk.add({
        { "<leader>f",   group = "file" },
        { "<leader>ff",  search.project_files,                                                 desc = "project files",      mode = "n" },
        { "<leader>fH",  command("silent !thunar $HOME &"),                                    desc = "home",               mode = "n" },
        { "<leader>fbD", command("BookmarkClearAll"),                                          desc = "Clear All Bookmark", mode = "n" },
        { "<leader>fba", command("BookmarkAnnotate"),                                          desc = "Add Bookmark",       mode = "n" },
        { "<leader>fbb", search.vim_book_marks,                                                desc = "Bookmarks",          mode = "n" },
        { "<leader>fbd", command("BookmarkClear"),                                             desc = "Clear Bookmark",     mode = "n" },
        { "<leader>fn",  command("enew"),                                                      desc = "New File",           mode = "n" },
        { "<leader>fo",  search.open_with_defualt,                                             desc = "externl open",       mode = "n" },
        { "<leader>fq",  utils.open_current_file_use_qtcreator,                                desc = "open in qtcreator",  mode = "n" },
        { "<leader>fr",  search.oldfiles,                                                      desc = "Open Recent File",   mode = "n" },
        { "<leader>ft",  search.project_tree_focus,                                            desc = "file tree",          mode = "n" },
        { "<leader>fd",  command(":Telescope file_browser path=%:p:h select_buffer=true<CR>"), desc = "file tree",          mode = "n" },
      })

      -- debug
      wk.add({
        { "<leader>d",  group = "debug" },
        { "<leader>di", command("VimspectorDebugInfo"),  desc = "print info",  mode = "n" },
        { "<leader>dl", command("VimspectorToggleLog"),  desc = "toggle log",  mode = "n" },
        { "<leader>do", command("VimspectorShowOutput"), desc = "show output", mode = "n" },
        { "<leader>ds", command("VimspectorReset"),      desc = "stop/reset",  mode = "n" },
        { "<leader>dw", command("VimspectorWatch"),      desc = "watch",       mode = "n" },
      })



      -- open
      wk.add({
        { "<leader>o",  group = "open" },
        { "<leader>o2", utils.open200,              desc = "200",                      mode = "n" },
        { "<leader>od", search.exploer_dir_current, desc = "externl open current dir", mode = "n" },
        { "<leader>op", search.exploer_dir_project, desc = "externl open project dir", mode = "n" },
      })

      -- buffer
      wk.add({
        { "<leader>b",  group = "buffer" },
        { "<leader>bd", jz.close_current_buffer,   desc = "nest buffer",     mode = "n" },
        { "<leader>bk", jz.close_current_buffer,   desc = "buffer kill",     mode = "n" },
        { "<leader>bn", command("BufSurfForward"), desc = "nest buffer",     mode = "n" },
        { "<leader>bp", command("BufSurfBack"),    desc = "prev buffer",     mode = "n" },
        { "<leader>bK", jz.delete_other_buffers,   desc = "buffer kill",     mode = "n" },
        { "<leader>bb", search.buffers,            desc = "buffer list",     mode = "n" },
        { "<leader>bB", search.project_buffers,    desc = "project buffers", mode = "n" },
      })

      -- windows
      wk.add({
        { "<leader>w",  group = "close other window", mode = "n" },
        { "<leader>w1", command("only"),              desc = "close other window", mode = "n" },
        { "<leader>w=", command("wincmd ="),          desc = "balance-window",     mode = "n" },
        { "<leader>wd", command("wincmd c"),          desc = "delete-window",      mode = "n" },
        { "<leader>wm", command("wincmd |"),          desc = "max-window",         mode = "n" },
        { "<leader>wn", command("tabnext"),           desc = "next tab",           mode = "n" },
        { "<leader>wp", command("tabprevious"),       desc = "previous tab",       mode = "n" },
        { "<leader>wq", command("qa"),                desc = "quit",               mode = "n" },
        { "<leader>ws", command("wincmd s"),          desc = "split-window-below", mode = "n" },
        { "<leader>wt", command("tabnew"),            desc = "new tab",            mode = "n" },
        { "<leader>wv", command("wincmd v"),          desc = "split-window-right", mode = "n" },
        { "<leader>ww", command("tabnew"),            desc = "new tab",            mode = "n" },
      })

      -- serach/symbol
      wk.add({
        { "<leader>s",  group = "search/symbol" },
        { "<leader>sh", command("Interestingwords --toggle"),  desc = "highlight words",          mode = "n" },
        { "<leader>ss", search.search_current_buffer,          desc = "symbol current buffer",    mode = "n" },
        { "<leader>sS", search.current_buffer_symbol_at_point, desc = "symbol current buffer",    mode = "n" },
        { "<leader>si", search.lsp_document_symbols,           desc = "symbol",                   mode = "n" },
        { "<leader>sp", search.project_current_symbols,        desc = "symbol project at point",  mode = "n" },
        { "<leader>sP", search.project_symbol_at_point,        desc = "symbol project at point",  mode = "n" },
        { "<leader>sd", search.directory_live_symbol,          desc = "symbol current directory", mode = "n" },
        { "<leader>sc", utils.uncolor_all_words,               desc = "unhighlight words",        mode = "n" },
      })

      -- help
      wk.add({
        { "<leader>h",  group = "help" },
        { "<leader>hm", cppman,        desc = "cppman", mode = "n" },
      })

      -- git
      wk.add({
        { "<leader>g",  group = "git" },
        { "<leader>gP", command("Git pull"),  desc = "git pull",   mode = "n" },
        { "<leader>gb", command("Git blame"), desc = "git blame",  mode = "n" },
        { "<leader>gg", command("tab Git"),   desc = "git status", mode = "n" },
        { "<leader>gl", command("tab Gclog"), desc = "git log",    mode = "n" },
        { "<leader>gp", command("Git push"),  desc = "git push",   mode = "n" },
      })

      -- tools
      wk.add({
        { "<leader>t",  group = "tools/toggle" },
        { "<leader>tc", command("Telescope colorscheme enable_preview=true"), desc = "colorscheme",         mode = "n" },
        { "<leader>tf", command("Telescope filetypes"),                       desc = "filetypes",           mode = "n" },
        { "<leader>tl", command("setlocal wrap!"),                            desc = "line wrap",           mode = "n" },
        { "<leader>tr", command("so $VIMHOME/init.vim"),                      desc = "refresh vimrc",       mode = "n" },
        { "<leader>tm", search.man,                                           desc = "man page",            mode = "n" },
        { "<leader>tu", command("PackerSync"),                                desc = "update plugins",      mode = "n" },
        { "<leader>td", Toggle_venn,                                          desc = "draw ascii diagrams", mode = "n" },
      })


      -- project
      wk.add({
        { "<leader>p",  group = "Project" },
        { "<leader>pb", search.project_buffers,                             desc = "Project buffers" },
        { "<leader>pd", jz.SubProjectFiles,                                 desc = "Find File" },
        { "<leader>pe", command("AsyncTaskEdit"),                           desc = "async edit" },
        { "<leader>pf", search.project_files,                               desc = "project files" },
        { "<leader>pp", command("Telescope projects"),                      desc = "projects" },
        { "<leader>pr", search.project_oldfiles,                            desc = "project recent files" },
        { "<leader>ps", command("Telescope lsp_dynamic_workspace_symbols"), desc = "workspace symbol" },
      })

      -- code
      wk.add({
        { "<leader>c",  group = "rename" },
        { "<leader>cr", vim.lsp.buf.rename,                                                desc = "rename" },
        { "<leader>cc", search.lsp_calltree,                                               desc = "calltree" },
        { "<leader>cp", search.project_live_symbols,                                       desc = "workspace_symbolf" },
        { "<leader>ce", function() telein.diagnostics({ cwd = rootdir(), bufnr = 0 }) end, desc = "workspace diagnostics", },
        { "<leader>cE", function() telein.diagnostics({ cwd = rootdir() }) end,            desc = "workspace diagnostics", },
      })


      wk.add({
        { "<leader>r",  group = "async stop" },
        { "<leader>rr", task_run,                 desc = "run", },
        { "<leader>rs", command("AsyncStop"),     desc = "async stop" },
        { "<leader>re", command("AsyncTaskEdit"), desc = "async tas edit" },
      })

      wk.add({
        { "<leader>d",  group = "svn" },
        { "<leader>dd", svn.svn_diff_current_buf, desc = "svn diff current" },
        { "<leader>dl", svn.svn_log_current_buf,  desc = "svn log current" },
        { "<leader>dL", svn.svn_log_project,      desc = "svn log project" },
        { "<leader>db", svn.svn_blame,            desc = "svn blame current" },
        { "<leader>du", svn.svn_update,           desc = "svn update" },
        { "<leader>dc", svn.svn_commit,           desc = "svn commit" },
        { "<leader>da", svn.svn_add_current_file, desc = "svn add current file" },
      })

      wk.add({
        { "<leader>,",   group = "all-major" },
        { "<leader>,d",  command("Dox"),                                                    desc = "anotaion func" },
        { "<leader>,c",  search.lsp_calltree,                                               desc = "calltree" },
        { "<leader>,p",  search.project_live_symbols,                                       desc = "workspace_symbolf" },
        { "<leader>,e",  function() telein.diagnostics({ cwd = rootdir(), bufnr = 0 }) end, desc = "document diagnostics", },
        { "<leader>,tt", command("Translate"),                                              desc = "translate" },
      })


      wk.add({
        { "<leader>",         group = "gloabl" },
        { "<leader><leader>", command("w"),                             desc = "save file" },
        { "<leader>q",        command("wincmd c"),                      desc = "delete-window" },
        { "<leader>1",        function() bufferline.go_to(1, true) end, desc = "buffer 1", },
        { "<leader>2",        function() bufferline.go_to(2, true) end, desc = "buffer 2", },
        { "<leader>3",        function() bufferline.go_to(3, true) end, desc = "buffer 3", },
        { "<leader>4",        function() bufferline.go_to(4, true) end, desc = "buffer 4", },
        { "<leader>5",        function() bufferline.go_to(5, true) end, desc = "buffer 5", },
        { "<leader>6",        function() bufferline.go_to(6, true) end, desc = "buffer 6", },
        { "<leader>7",        function() bufferline.go_to(7, true) end, desc = "buffer 7", },
        { "<leader>8",        function() bufferline.go_to(8, true) end, desc = "buffer 8", },
        { "<leader>9",        function() bufferline.go_to(9, true) end, desc = "buffer 9", },
      })

      wk.add({
        { "g",  group = "goto" },
        { "gd", function() vim.cmd([[Telescope lsp_definitions]]) end, desc = "lsp+definition" },
        { "gi", vim.lsp.buf.declaration,                               desc = "lsp+definition" },
        { "gv", lsp_definitions_vsplit,                                desc = "lsp+definition/vsplit", },
        { "gs", lsp_definitions_split,                                 desc = "lsp+definition/split", },
        { "gr", search.project_lsp_ref,                                desc = "lsp+references" },
        { "gf", vim.lsp.buf.code_action,                               desc = "quickfix" },
        { "gy", ":lua ___gdc('v')<cr>",                                desc = "comment and yank",      mode = { "n", "v" }, silent = false },
        { "gx", nil,                                                   desc = "open" },
      })

      wk.add({
        { "<C-a>",           "<Home>",                                     desc = "begin of line", mode = { "i", "c" },      silent = false },
        { "<C-e>",           "<End>",                                      desc = "end of line",   mode = { "i", "v", "c" }, silent = false },
        { "<C-e>",           "A",                                          desc = "end of line",   mode = { "n" },           silent = false },
        { "<C-j>",           "<Down>",                                     desc = "next line",     mode = { "n", "i", "c" }, silent = false },
        { "<C-k>",           "<Up>",                                       desc = "next line",     mode = { "n", "i", "c" }, silent = false },
        { "<C-f>",           "<Right>",                                    desc = "forward char",  mode = { "n", "i", "c" }, silent = false },
        { "<C-b>",           "<Left>",                                     desc = "backward char", mode = { "n", "i", "c" }, silent = false },

        { "<A-f>",           "<C-Right>",                                  desc = "forward word",  mode = { "n", "i", "c" }, silent = false },

        { "<A-j>",           "<C-W>j",                                     desc = "down win",      mode = { "n" },           silent = false },
        { "<A-k>",           "<C-W>k",                                     desc = "up win",        mode = { "n" },           silent = false },
        { "<A-h>",           "<C-W>h",                                     desc = "right win",     mode = { "n" },           silent = false },
        { "<A-l>",           "<C-W>l",                                     desc = "left win",      mode = { "n" },           silent = false },
        { "<C-c>",           "<esc>",                                      desc = "normal mode",   mode = { "i" },           silent = true },

        { "Q",               ":cclose<CR>",                                desc = "quit",          mode = { "n", "v" },      silent = true },

        { "<A-->",           ":resize -1<CR>",                             desc = "font -",        mode = { "n" },           silent = true },
        { "<A-=>",           ":resize +1<CR>",                             desc = "font +",        mode = { "n" },           silent = true },

        { "<A-<>",           ":SidewaysLeft<CR>",                          desc = "SidewaysLeft",  mode = { "n" },           silent = true },
        { "<A->>",           ":SidewaysRight<CR>",                         desc = "SidewaysRight", mode = { "n" },           silent = true },

        { "<localleader>tt", ":Translate<cr>",                             desc = "Translate",     mode = { "v" },           silent = true },
        { ",!",              ":!bash<cr>",                                 desc = "",              mode = "v",               silent = true },
        { ",,",              "<esc><cmd>lua lsp_format_region()<CR>",      desc = "",              mode = "v",               silent = true },
        { "gf",              ":lua require('base.search').extract() <cr>", desc = "",              mode = "v",               silent = true },
        { ",g",              ":TSCppDefineClassFunc<cr>",                  desc = "",              mode = "v",               silent = true },

        { "<A-Down>",        ":MoveLine(1)<CR>",                           desc = "",              mode = "n",               silent = true },
        { "<A-Up>",          ":MoveLine(-1)<CR>",                          desc = "",              mode = "n",               silent = true },
        { "<A-Down>",        ":MoveBlock(1)<CR>",                          desc = "",              mode = "v",               silent = true },
        { "<A-Up>",          ":MoveBlock(-1)<CR>",                         desc = "",              mode = "v",               silent = true },

        { "<A-x>",           ":",                                          desc = "",              mode = { "n", "v" },      silent = false },
        { "<leader>tv",      require('edit.hex-view').view,                desc = "hexview",       mode = { "v" },           silent = false },
      })
    end
  },
}
