vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use { 'folke/which-key.nvim', branch = 'main' }
	use { 'rafamadriz/friendly-snippets', branch = 'main' }
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'mbbill/fencview'
	use { 'nvim-telescope/telescope.nvim', branch = 'master' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', branch = 'main' }
	use { 'crispgm/telescope-heading.nvim', branch = 'main' }
	use { 'tom-anders/telescope-vim-bookmarks.nvim', branch = 'main' }
	use { 'GustavoKatel/telescope-asynctasks.nvim', branch = 'main' }
	use 'benfowler/telescope-luasnip.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'

	use 'ton/vim-bufsurf'
	use 'mfussenegger/nvim-dap'
	use { 'Pocco81/DAPInstall.nvim', branch = 'main' }
	use 'akinsho/toggleterm.nvim'
	use 'chiel92/vim-autoformat'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-lualine/lualine.nvim'
	use 'akinsho/nvim-bufferline.lua'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'neovim/nvim-lspconfig'
	use { 'williamboman/nvim-lsp-installer', branch = 'main' }
	use 'windwp/nvim-autopairs'
	use 'vimwiki/vimwiki'
	use 'MattesGroeger/vim-bookmarks'
	use 'vim-scripts/bufkill.vim'
	use 'voldikss/vim-floaterm'
	use 'karb94/neoscroll.nvim'
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'mhartington/formatter.nvim'
	use 'onsails/lspkind-nvim'
	use 'voldikss/vim-translator'
	use 'p00f/nvim-ts-rainbow'
	use 'glepnir/dashboard-nvim'
	use { 'ahmedkhalf/project.nvim', branch = 'main' }
	use 'stevearc/aerial.nvim'
	--use 'TimUntersberger/neogit'
	--use 'f-person/git-blame.nvim'
	use 'kazhala/close-buffers.nvim'
	use 'weilbith/nvim-floating-tag-preview'
	use 'romgrk/nvim-treesitter-context'
	use { 'folke/todo-comments.nvim', branch = 'main' }
	use 'ray-x/lsp_signature.nvim'
	use { 'gelguy/wilder.nvim', run = ':UpdateRemoteuseins' }
	use '907th/vim-auto-save'
	use { 'nvim-neorg/neorg', branch = 'main' }

	use 'kristijanhusak/orgmode.nvim'
	use 'chentau/marks.nvim'
	use { 'kevinhwang91/nvim-bqf', branch = 'main' }


	use { 'lilydjwg/fcitx.vim', branch = 'fcitx5' }
	---colors
	use 'mhartington/oceanic-next'
	use { 'Mofiqul/vscode.nvim', branch = 'main' }
	use { 'marko-cerovac/material.nvim', branch = 'main' }
	use 'keyvchan/monokai.nvim'
	use { 'rktjmp/lush.nvim', branch = 'main' }
	use { 'npxbr/gruvbox.nvim', branch = 'main' }
	use { 'EdenEast/nightfox.nvim', branch = 'main' }
	use { 'folke/tokyonight.nvim', branch = 'main' }
	use 'ishan9299/nvim-solarized-lua'
	use { 'rafamadriz/neon', branch = 'main' }
	use 'bluz71/vim-nightfly-guicolors'
	use 'bluz71/vim-moonfly-colors'
	use 'sainnhe/sonokai'
	use { 'lourenci/github-colors', branch = 'main' }
	use 'ayu-theme/ayu-vim'
	use { 'dracula/vim', as = 'dracula' }
	---"""

	use 'skanehira/preview-markdown.vim'
	use 'rhysd/accelerated-jk'
	use 'mhinz/vim-grepper'
	use 'vim-scripts/DoxygenToolkit.vim'
	use 'plasticboy/vim-markdown'
	use 'terryma/vim-expand-region'
	use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }
	use 'easymotion/vim-easymotion'
	use 'haya14busa/incsearch.vim'
	use 'haya14busa/incsearch-easymotion.vim'
	use 'haya14busa/incsearch-fuzzy.vim'
	use 'mg979/vim-visual-multi'
	use 'pseewald/vim-anyfold'
	use 'mattn/emmet-vim'
	use 'skywind3000/asynctasks.vim'
	use 'skywind3000/asyncrun.vim'
	use 'tpope/vim-surround'
	use 'rakr/vim-one'
	use 'tpope/vim-fugitive'
	use 'lfv89/vim-interestingwords'
	use 'kana/vim-textobj-user'
	use 'sgur/vim-textobj-parameter'
	use 'rhysd/vim-textobj-anyblock'
	use 'thinca/vim-qfreplace'
	use 'markonm/traces.vim'
	use 'othree/html5.vim'
	use 'mklabs/vim-json'
	use 'kana/vim-textobj-line'
	use 'cespare/vim-toml'
	use 'itchyny/vim-cursorword'
	use 'puremourning/vimspector'
	use 'godlygeek/tabular'
	use 'AndrewRadev/sideways.vim'
	use 'rust-lang/rust.vim'
	use 'matveyt/vim-qmake'

	use { 'hrsh7th/cmp-nvim-lsp', branch = 'main' }
	use { 'hrsh7th/cmp-path', branch = 'main' }
	use { 'hrsh7th/nvim-cmp', branch = 'main' }
	use { 'hrsh7th/cmp-buffer', branch = 'main' }

	use 'kyazdani42/nvim-tree.lua'
	use { 'fedepujol/move.nvim', branch = 'main' }
	use 'numToStr/Comment.nvim'
	use { 'folke/lua-dev.nvim', branch = 'main' }
	use { 'j-hui/fidget.nvim', branch = 'main' }
end)
