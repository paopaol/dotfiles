require("Comment").setup({})

local U = require("Comment.utils")
local api = require("Comment.api")
local A = vim.api

function _G.___gdc(vmode)
  local range = U.get_region(vmode)
  local cfg = require("Comment.config").config
  local ctx = {
    cmode = U.cmode.toggle, -- Always comment the line
    cmotion = U.cmotion.line, -- Line action `gy2j`
    ctype = U.ctype.line, -- Use line style comment
    range = range,
  }

  local lines = U.get_lines(range)

  -- Copying the block
  local srow = ctx.range.erow
  A.nvim_buf_set_lines(0, srow, srow, false, lines)

  -- Doing the comment
  api.toggle.linewise(vmode)

  -- Move the cursor
  local erow = srow + 1
  local line = U.get_lines({ srow = srow, erow = erow })
  local _, col = string.find(line[1], "^%s*")
  A.nvim_win_set_cursor(0, { erow, col })
end
