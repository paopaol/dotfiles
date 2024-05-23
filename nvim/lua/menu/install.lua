return {
  { "nvim-telescope/telescope.nvim",            branch = "master" },
  "paopaol/telescope-command.nvim",
  "benfowler/telescope-luasnip.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make",   branch = "main" },
  { "tom-anders/telescope-vim-bookmarks.nvim",  branch = "main" },
  {
    "GustavoKatel/telescope-asynctasks.nvim",
    branch = "main",
    dependencies = {
      "skywind3000/asynctasks.vim",
      "skywind3000/asyncrun.vim",
    },
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  {
    'paopaol/telescope-git-diffs.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    lazy = true
  },
}
