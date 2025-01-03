return {
  { "nvim-telescope/telescope.nvim",            branch = "master" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make",     branch = "main" },
  { "tom-anders/telescope-vim-bookmarks.nvim",  branch = "main" },
  { "GustavoKatel/telescope-asynctasks.nvim",   event = "VeryLazy", branch = "main", dependencies = { "skywind3000/asynctasks.vim", "skywind3000/asyncrun.vim", }, },
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    'paopaol/telescope-git-diffs.nvim',
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", },
    lazy = true,
    config = function()
      require('telescope').setup {
        extensions = {
          git_diffs = {
            enable_preview_diff = false
          }
        }
      }
    end
  },
  { "nanotee/zoxide.vim" },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } }
}
