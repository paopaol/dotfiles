local utils = require("base.utils")

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", mode = "nv", buffer = true },
})
