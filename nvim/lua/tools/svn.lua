local utils = require('base.utils')


local M = {}
M.svn_diff_current_buf = function()
  vim.cmd([[silent !"D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:diff /path:"%" /notempfile /closeonend]])
end

M.svn_log_current_buf = function()
  vim.cmd([[silent !"D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:log /path:"%" /notempfile /closeonend]])
end

M.svn_log_project = function()
  local cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:log /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  vim.cmd(cmd)
end


M.svn_blame = function()
  local cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:blame /path:\"%s\" /line:%d /notempfile /closeonend &\"', vim.fn.expand("%"), vim.fn.line("."))
  vim.cmd(cmd)
end

M.svn_update = function()
  local cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:update /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  vim.cmd(cmd)
end

M.svn_commit = function()
  local cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:commit /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  vim.cmd(cmd)
end

M.svn_add_current_file = function()
  local cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:add /path:\"%s\" /notempfile /closeonend\"', vim.fn.expand("%"))
  vim.cmd(cmd)
end

return M
