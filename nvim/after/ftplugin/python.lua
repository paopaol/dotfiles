local utils = require("base.utils")

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
  { "<localleader>qd", utils.command("silent ! designer"), desc = "qt designer", buffer = true },
})

