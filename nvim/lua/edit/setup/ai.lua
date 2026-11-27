return {
  {
    "folke/sidekick.nvim",
    version = "*",
    cmd = { "Sidekick" },
    opts = {
      cli = {
        tools = {
          codebuddy = {
            cmd = { "codebuddy" },
            is_proc = "\\<codebuddy\\>",
          },
        },
        mux = {
          backend = "tmux",
          enabled = false,
          create = "split",
          split = {
            vertical = true,
            size = 0.45,
          },
        },
        win = {
          layout = "float",
          split = {
            width = 110,
            height = 50,
          },
          float = {
            width = 0.9,
            height = 0.9,
            border = "rounded",
            title = "AI",
            title_pos = "center",
          },
          keys = {
            -- sidekick 的默认 keys 会与这里深合并，省略等于沿用默认（q / <c-q> 都会 hide），
            -- 要真正禁用必须显式写 false
            hide_n = false,
            hide_ctrl_q = false,
            passthrough_esc = {
              "<Esc>",
              function()
                return "<Esc>"
              end,
              mode = "t",
              expr = true,
            },
            buffers = { "<c-b>", "buffers", mode = "nt", desc = "open buffer picker" },
            files = { "<c-f>", "files", mode = "nt", desc = "open file picker" },
            prompt = { "<c-p>", "prompt", mode = "t", desc = "insert prompt or context" },
            stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
          },
        },
      },
    },
  },
}
