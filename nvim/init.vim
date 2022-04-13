
let $VIMHOME = fnamemodify(expand('<sfile>'), ':p')
let $VIMHOME = resolve($VIMHOME)
let $VIMHOME =  fnamemodify(expand($VIMHOME), ':p:h')


augroup plug
	call plug#begin('~/.vim/plugged')
	Plug 'rafamadriz/friendly-snippets', {'branch': 'main'}
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'mbbill/fencview'
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'ton/vim-bufsurf'
	Plug 'mfussenegger/nvim-dap'
	Plug 'Pocco81/DAPInstall.nvim',{'branch':'main'}
	Plug 'akinsho/toggleterm.nvim'
	Plug 'chiel92/vim-autoformat'
	Plug 'paopaol/telescope-ctags.nvim'
	Plug 'paopaol/telescope-vimsnip.nvim' , {'branch': 'main'}
	Plug 'paopaol/cpp-mode' , {'branch': 'main'}
	Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'akinsho/nvim-bufferline.lua'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }
	Plug 'nvim-telescope/telescope.nvim', {'branch': 'master'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'folke/which-key.nvim', {'branch':'main'}
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/nvim-lsp-installer', {'branch':'main'}
	Plug 'windwp/nvim-autopairs'
	Plug 'vimwiki/vimwiki'
	Plug 'MattesGroeger/vim-bookmarks'
	Plug 'vim-scripts/bufkill.vim'
	Plug 'crispgm/telescope-heading.nvim', {'branch':'main'}
	Plug 'voldikss/vim-floaterm'
	Plug 'karb94/neoscroll.nvim'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'mhartington/formatter.nvim'
	Plug 'onsails/lspkind-nvim'
	Plug 'voldikss/vim-translator'
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'glepnir/dashboard-nvim'
	Plug 'ahmedkhalf/project.nvim', {'branch': 'main'}
	Plug 'stevearc/aerial.nvim'
	" Plug 'TimUntersberger/neogit'
	" Plug 'f-person/git-blame.nvim'
	Plug 'kazhala/close-buffers.nvim'
	Plug 'weilbith/nvim-floating-tag-preview'
	Plug 'romgrk/nvim-treesitter-context'
	Plug 'weilbith/nerdtree_choosewin-plugin'
	Plug 'folke/todo-comments.nvim' , {'branch': 'main'}
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug '907th/vim-auto-save'
	Plug 'nvim-neorg/neorg', {'branch':'unstable'}

	Plug 'kristijanhusak/orgmode.nvim'
	Plug 'chentau/marks.nvim'
	Plug 'kevinhwang91/nvim-bqf' , {'branch':'main'}


	Plug 'lilydjwg/fcitx.vim', {'branch' : 'fcitx5'}
	"""colors
	Plug 'mhartington/oceanic-next'
	Plug 'Mofiqul/vscode.nvim', {'branch': 'main'}
	Plug 'marko-cerovac/material.nvim', {'branch':'main'}
	Plug 'keyvchan/monokai.nvim'
	Plug 'rktjmp/lush.nvim', {'branch':'main'}
	Plug 'npxbr/gruvbox.nvim', {'branch':'main'}
	Plug 'EdenEast/nightfox.nvim', {'branch':'main'}
	Plug 'folke/tokyonight.nvim', {'branch':'main'}
	Plug 'ishan9299/nvim-solarized-lua'
	Plug 'rafamadriz/neon', {'branch':'main'}
	Plug 'bluz71/vim-nightfly-guicolors'
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'sainnhe/sonokai'
	Plug 'lourenci/github-colors', {'branch':'main'}
	Plug 'ayu-theme/ayu-vim'
	Plug 'dracula/vim', { 'as': 'dracula' }
	"""

	Plug 'skanehira/preview-markdown.vim'
	Plug 'rhysd/accelerated-jk'
	Plug 'mhinz/vim-grepper'
	Plug 'vim-scripts/DoxygenToolkit.vim'
	Plug 'plasticboy/vim-markdown'
	Plug 'terryma/vim-expand-region'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
	Plug 'easymotion/vim-easymotion'
	Plug 'haya14busa/incsearch.vim'
	Plug 'haya14busa/incsearch-easymotion.vim'
	Plug 'haya14busa/incsearch-fuzzy.vim'
	Plug 'mg979/vim-visual-multi'
	Plug 'pseewald/vim-anyfold'
	Plug 'mattn/emmet-vim'
	Plug 'skywind3000/asynctasks.vim'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'tpope/vim-surround'
	Plug 'rakr/vim-one'
	Plug 'tpope/vim-fugitive'
	Plug 'lfv89/vim-interestingwords'
	Plug 'kana/vim-textobj-user'
	Plug 'sgur/vim-textobj-parameter'
	Plug 'rhysd/vim-textobj-anyblock'
	Plug 'thinca/vim-qfreplace'
	Plug 'markonm/traces.vim'
	Plug 'othree/html5.vim'
	Plug 'mklabs/vim-json'
	Plug 'kana/vim-textobj-line'
	Plug 'cespare/vim-toml'
	Plug 'itchyny/vim-cursorword'
	Plug 'puremourning/vimspector'
	Plug 'godlygeek/tabular'
	Plug 'AndrewRadev/sideways.vim'
	Plug 'rust-lang/rust.vim'
	Plug 'matveyt/vim-qmake'

	Plug 'hrsh7th/cmp-nvim-lsp' , {'branch':'main'}
	Plug 'hrsh7th/cmp-path', {'branch':'main'}
	Plug 'hrsh7th/nvim-cmp', {'branch':'main'}
	Plug 'hrsh7th/cmp-buffer', {'branch':'main'}
	Plug 'tom-anders/telescope-vim-bookmarks.nvim', {'branch':'main'}
	Plug 'GustavoKatel/telescope-asynctasks.nvim', {'branch':'main'}
	Plug 'benfowler/telescope-luasnip.nvim'
	Plug 'kyazdani42/nvim-tree.lua'
	Plug 'fedepujol/move.nvim', {'branch':'main'}
	Plug 'numToStr/Comment.nvim'
	Plug 'folke/lua-dev.nvim', {'branch':'main'}
	Plug 'j-hui/fidget.nvim', {'branch':'main'}
	call plug#end()
augroup END

lua require('init')

call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-j>',
      \ 'previous_key': '<C-k>',
      \ 'accept_key': '<Tab>',
      \ 'reject_key': '<C-c>',
      \ })

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': ['fd', '-tf'],
      \       'dir_command': ['fd', '-tf'],
      \       'filters': ['fuzzy_filter', 'difflib_sorter'],
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#vim_fuzzy_filter(),
      \     }),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ }))

