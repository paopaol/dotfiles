local utils = require("base.utils")

require("base.utils").make_keymap({ "go" }, "go-group", {
  { "<localleader>,", utils.format_buffer, desc = "formatting" },
})
