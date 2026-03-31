local utils = require("base.utils")

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", mode = "nv", buffer = true },
  { "<tab>", utils.command("normal! za"), desc = "expand", buffer = true },
})

require("nvim-ts-autotag").setup({ filetypes = { "html", "xml" } })
