local wk = require("which-key")
local utils = require("base.utils")

local format = function()
  require("tools.markdown_formater.markdown").format_region()
  utils.format_buffer()
end

_G.whichkeyMarkdown = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",

      [","] = { format, "formatting", buffer = buf },
      ["p"] = { utils.command("MarkdownPreview"), "preview", buffer = buf },
    },
  })
  wk.register({
    ["<leader>"] = {
      name = "major",

      ["si"] = { function () vim.cmd("Telescope heading") end, "heading", buffer = buf },
    },
  })
end

vim.cmd([[ autocmd FileType markdown lua whichkeyMarkdown() ]])
