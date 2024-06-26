return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      'skywind3000/asyncrun.vim'
    },
    lazy = true,
    cmd = 'Neogit',
    opts = {
      disable_signs = false,
      disable_hint = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      auto_refresh = false,
      disable_builtin_notifications = false,
      use_magit_keybindings = false,
      commit_popup = {
        kind = "split",
      },
      kind = "tab",
      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = false,
      },
      section = {
        untracked = {
          folded = true,
        },
        unstaged = {
          folded = true,
        },
        staged = {
          folded = true,
        },
        stashes = {
          folded = true,
        },
        unpulled = {
          folded = true,
        },
        unmerged = {
          folded = true,
        },
        recent = {
          folded = true,
        },
      }
    },
    config = function(_, opts)
      require("neogit").setup(opts)
    end
  },
}
