local wk = require("which-key")
local utils = require('base.utils')

_G.whichkeyMarkdown = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",

      [","] = { utils.command("FormatWrite"), "formatting", buffer = buf },
      ["p"] = { utils.command("MarkdownPreview"), "preview", buffer = buf }
    }
  })
end

vim.cmd(([[ autocmd FileType markdown lua whichkeyMarkdown() ]]))
