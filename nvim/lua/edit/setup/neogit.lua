return {
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    -- 只留必需依赖：diffview/asyncrun 是可选集成，
    -- 声明成依赖会让 lazy 在打开 neogit 时连带加载它们（实测多 ~30-50ms）
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
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
      },
    },
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },
}
