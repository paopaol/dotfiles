vim.treesitter.start()

local utils = require("base.utils")

local format = function()
  require("tools.markdown_formater.markdown").format_region()
  utils.format_buffer()
end

require("which-key").add({
  { "<localleader>,", format, desc = "formatting", buffer = true },
  { "<localleader>p", utils.command("MarkdownPreview"), desc = "preview", buffer = true },
})
