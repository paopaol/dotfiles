return {
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          end_key = "e",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          hightlight = "Search",
        },
        ignored_next_char = "[%w%.%(%)]",
      })
    end,
  },
}
