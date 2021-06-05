local wk = require("which-key")
-- As an example, we will the following mappings:
--  1. <leader>fn new file
--  2. <leader>fr show recent files
--  2. <leader>ff find files
--

wk.register({
      ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "lsp+hover" },
      ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "lsp+definition" },
      ["gr"] = { "<cmd>Telescope lsp_references<cr>", "lsp+references" },
})

wk.register({
  ["<leader>f"] = { name = "+file" },

  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  ["<leader>fp"] = { "<cmd>call TelescopeProjectFiles()<cr>", "ProjectFiles" },
  ["<leader>fs"] = { "<cmd>w<cr>", "save file" },
})

wk.register({
  ["<leader>b"] = { name = "+buffer" },

  ["<leader>bb"] = { "<cmd>Telescope buffers<cr>", "buffer list" },
  ["<leader>bn"] = { "<cmd>bn<cr>", "nest buffer" },
  ["<leader>bp"] = { "<cmd>bp<cr>", "prev buffer" },
  ["<leader>bk"] = { "<cmd>Bclose<cr>", "buffer kill" },
  ["<leader>bh"] = { "<cmd>Startify<cr>", "home" },
})

wk.register({
  ["<leader>w"] = { name = "+windows" },

  ["<leader>w1"] = { "<cmd>only<cr>", "close other window" },
  ["<leader>wd"] = { "<cmd>normal! <C-W>c<cr>", "delete-window" },
  ["<leader>w="] = { "<cmd>normal! <C-W>=<cr>", "balance-window" },
  ["<leader>wm"] = { "<cmd>normal! <C-W>|<cr>", "max-window" },
  ["<leader>ws"] = { "<cmd>normal! <C-W>s<cr>", "split-window-below" },
  ["<leader>wv"] = { "<cmd>normal! <C-W>v<cr>", "split-window-right" },
  ["<leader>wq"] = { "<cmd>qa<cr>", "quit" },
})

wk.register({
  ["<leader>s"] = { name = "+windows" },

  ["<leader>ss"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "search current buffer" },
  ["<leader>sl"] = { "<cmd>Telescope treesitter<cr>", "symbol" },
  ["<leader>sh"] = { "<cmd>call InterestingWords(\"n\")<cr>", "highlight words" },
  ["<leader>sc"] = { "<cmd>call Uncolor_all_words()<cr>", "unhighlight words" },
})


wk.register({
  ["<leader>g"] = { name = "+git" },

  ["<leader>gs"] = { "<cmd>Git<cr>", "git status" },
  ["<leader>gb"] = { "<cmd>Git blame<cr>", "git blame" },
  ["<leader>gl"] = { "<cmd>Gclog<cr>", "git log" },
  ["<leader>gp"] = { "<cmd>Git push<cr>", "git push" },
  ["<leader>gP"] = { "<cmd>Git pull<cr>", "git pull" },
})

wk.register({
  ["<leader>t"] = { name = "+tools/toggle" },

  ["<leader>tc"] = { "<cmd>Telescope colorscheme<cr>", "colorscheme" },
  ["<leader>tl"] = { "<cmd>setlocal wrap!<cr>", "line wrap" },
  ["<leader>tf"] = { "<cmd>Telescope filetypes<cr>", "filetypes" },
  ["<leader>tr"] = { "<cmd>so $VIMHOME/init.vim<cr>", "refresh vimrc" },
})

wk.register({
  ["<leader>l"] = { name = "+lsp" },

  ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
})


vim.cmd(([[
autocmd FileType cpp   lua whichkeyrCpp()
]]))

_G.whichkeyrCpp = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "cpp",
      [","] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "formatting", buffer = buf },
    },
  })
end

_G.whichkeyrCmake = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "cmake",
      [","] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "formatting", buffer = buf },
    },
  })
end
