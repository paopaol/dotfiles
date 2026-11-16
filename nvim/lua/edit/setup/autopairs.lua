return {
  {
    -- 替代 nvim-autopairs（其 fast_wrap <M-e> 一并移除）
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },
}
