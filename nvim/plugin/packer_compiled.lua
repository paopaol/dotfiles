-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["DAPInstall.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\DAPInstall.nvim",
    url = "https://github.com/ravenxrz/DAPInstall.nvim"
  },
  ["DoxygenToolkit.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\DoxygenToolkit.vim",
    url = "https://github.com/vim-scripts/DoxygenToolkit.vim"
  },
  LuaSnip = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["accelerated-jk"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\accelerated-jk",
    url = "https://github.com/rhysd/accelerated-jk"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\asynctasks.vim",
    url = "https://github.com/skywind3000/asynctasks.vim"
  },
  ["bufkill.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\bufkill.vim",
    url = "https://github.com/vim-scripts/bufkill.vim"
  },
  ["clangd_extensions.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["close-buffers.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\close-buffers.nvim",
    url = "https://github.com/kazhala/close-buffers.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-doxygen"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-doxygen",
    url = "https://github.com/paopaol/cmp-doxygen"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tabnine"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["cpp-mode"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cpp-mode",
    url = "https://github.com/paopaol/cpp-mode"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["e-kaput.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\e-kaput.nvim",
    url = "https://github.com/kaputi/e-kaput.nvim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["fcitx.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fcitx.vim",
    url = "https://github.com/lilydjwg/fcitx.vim"
  },
  fencview = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fencview",
    url = "https://github.com/mbbill/fencview"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["incsearch-easymotion.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\incsearch-easymotion.vim",
    url = "https://github.com/haya14busa/incsearch-easymotion.vim"
  },
  ["incsearch-fuzzy.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\incsearch-fuzzy.vim",
    url = "https://github.com/haya14busa/incsearch-fuzzy.vim"
  },
  ["incsearch.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\incsearch.vim",
    url = "https://github.com/haya14busa/incsearch.vim"
  },
  ["interestingwords.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\interestingwords.nvim",
    url = "https://github.com/leisiji/interestingwords.nvim"
  },
  ["litee-calltree.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\litee-calltree.nvim",
    url = "https://github.com/ldelossa/litee-calltree.nvim"
  },
  ["litee.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\litee.nvim",
    url = "https://github.com/ldelossa/litee.nvim"
  },
  ["lsp-semantic.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp-semantic.nvim",
    url = "https://github.com/Thiago4532/lsp-semantic.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["marks.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["move.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\move.nvim",
    url = "https://github.com/fedepujol/move.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neogen",
    url = "https://github.com/danymat/neogen"
  },
  neogit = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  neorg = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-base16",
    url = "https://github.com/RRethy/nvim-base16"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-cursorline"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cursorline",
    url = "https://github.com/yamatsum/nvim-cursorline"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-floating-tag-preview"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-floating-tag-preview",
    url = "https://github.com/weilbith/nvim-floating-tag-preview"
  },
  ["nvim-keymap-amend"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-keymap-amend",
    url = "https://github.com/anuvyklack/nvim-keymap-amend"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-treesitter-cpp-tools"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-cpp-tools",
    url = "https://github.com/Badhi/nvim-treesitter-cpp-tools"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["pretty-fold.nvim"] = {
    config = { "\27LJ\2\na\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24pretty-fold.preview\nsetup\16pretty-fold\frequire\0" },
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["renamer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["sideways.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\sideways.vim",
    url = "https://github.com/AndrewRadev/sideways.vim"
  },
  ["starry.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\starry.nvim",
    url = "https://github.com/ray-x/starry.nvim"
  },
  tabular = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-asynctasks.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-asynctasks.nvim",
    url = "https://github.com/GustavoKatel/telescope-asynctasks.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-heading.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-heading.nvim",
    url = "https://github.com/crispgm/telescope-heading.nvim"
  },
  ["telescope-luasnip.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-luasnip.nvim",
    url = "https://github.com/benfowler/telescope-luasnip.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-vim-bookmarks.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-vim-bookmarks.nvim",
    url = "https://github.com/tom-anders/telescope-vim-bookmarks.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\traces.vim",
    url = "https://github.com/markonm/traces.vim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vcscommand.vim"] = {
    config = { "\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\19no_plugin_maps\6g\bvim\0" },
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vcscommand.vim",
    url = "https://github.com/vim-scripts/vcscommand.vim"
  },
  ["vim-anyfold"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-anyfold",
    url = "https://github.com/pseewald/vim-anyfold"
  },
  ["vim-auto-save"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-auto-save",
    url = "https://github.com/907th/vim-auto-save"
  },
  ["vim-autoformat"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-autoformat",
    url = "https://github.com/chiel92/vim-autoformat"
  },
  ["vim-bookmarks"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-bookmarks",
    url = "https://github.com/MattesGroeger/vim-bookmarks"
  },
  ["vim-bufsurf"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-bufsurf",
    url = "https://github.com/ton/vim-bufsurf"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-expand-region"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-expand-region",
    url = "https://github.com/terryma/vim-expand-region"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-grepper",
    url = "https://github.com/mhinz/vim-grepper"
  },
  ["vim-json"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-json",
    url = "https://github.com/mklabs/vim-json"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-one"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-one",
    url = "https://github.com/rakr/vim-one"
  },
  ["vim-qfreplace"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-qfreplace",
    url = "https://github.com/thinca/vim-qfreplace"
  },
  ["vim-qmake"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-qmake",
    url = "https://github.com/matveyt/vim-qmake"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-textobj-anyblock"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-anyblock",
    url = "https://github.com/rhysd/vim-textobj-anyblock"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-line",
    url = "https://github.com/kana/vim-textobj-line"
  },
  ["vim-textobj-parameter"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-parameter",
    url = "https://github.com/sgur/vim-textobj-parameter"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-translator"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  vimspector = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vimspector",
    url = "https://github.com/puremourning/vimspector"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "C:\\Users\\lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: vcscommand.vim
time([[Config for vcscommand.vim]], true)
try_loadstring("\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\19no_plugin_maps\6g\bvim\0", "config", "vcscommand.vim")
time([[Config for vcscommand.vim]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
try_loadstring("\27LJ\2\na\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24pretty-fold.preview\nsetup\16pretty-fold\frequire\0", "config", "pretty-fold.nvim")
time([[Config for pretty-fold.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
