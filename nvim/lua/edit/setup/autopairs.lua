return {
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          end_key = "e",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          hightlight = "Search",
          map_cr = false,
        },
        ignored_next_char = "[%w%.%(%)]",
      })
    end,
  },
}
