local M = {}

-- DAP 工具函数
M.hover = function()
  local widgets = require("dap.ui.widgets")
  widgets.hover()
end

M.preview = function()
  require("dap.ui.widgets").preview()
end

M.scopes = function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end

M.frames = function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end

return M
