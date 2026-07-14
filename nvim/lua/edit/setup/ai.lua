return {
  {
    "folke/sidekick.nvim",
    version = "*",
    cmd = { "Sidekick" },
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
          create = "split",
          split = {
            vertical = true, -- vertical or horizontal split
            size = 0.45, -- size of the split (0-1 for percentage)
          },
        },
        win = {
          layout = "right",
          split = {
            width = 110, -- set to 0 for default split width
            height = 50, -- set to 0 for default split height
          },
          float = {
            width = 0.9,
            height = 0.9,
          },
          keys = {
            buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
            files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
            hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
            hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "hide the terminal window" },
            hide_ctrl_dot = { "<c-.>", "hide", mode = "nt", desc = "hide the terminal window" },
            hide_ctrl_z = {
              "<c-z>",
              "blur",
              mode = "nt",
              desc = "go back to the previous window without hiding the terminal",
            },
            prompt = { "<c-p>", "prompt", mode = "t", desc = "insert prompt or context" },
            stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
            nav_left = { "<A-h>", "nav_left", expr = true, desc = "navigate to the left window" },
            nav_down = { "<c-j>", "nav_down", expr = true, desc = "navigate to the below window" },
            nav_up = { "<c-k>", "nav_up", expr = true, desc = "navigate to the above window" },
            nav_right = { "<c-l>", "nav_right", expr = true, desc = "navigate to the right window" },
          },
        },
      },
    },
  },
}
