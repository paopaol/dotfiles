local utils = require('base.utils')


local M = {}
M.svn_diff_current_buf = function()
  if vim.fn.has('win32') == 1 then
    vim.cmd([[silent !"D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:diff /path:"%" /notempfile /closeonend]])
  else
    local cmd = string.format('silent ! kdesvn exec diff %s &', vim.fn.expand("%"))
    vim.cmd(cmd)
  end
end

M.svn_log_current_buf = function()
  if vim.fn.has('win32') == 1 then
    vim.cmd([[silent !"D:\Program Files\TortoiseSVN\bin\TortoiseProc.exe" /command:log /path:"%" /notempfile /closeonend]])
  else
    local cmd = string.format('silent ! kdesvn exec log %s &', vim.fn.expand("%"))
    vim.cmd(cmd)
  end
end

M.svn_log_project = function()
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:log /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  else
    cmd = string.format('silent ! kdesvn exec log %s &', utils.rootdir())
  end
  vim.cmd(cmd)
end


M.svn_blame = function()
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:blame /path:\"%s\" /line:%d /notempfile /closeonend &\"', vim.fn.expand("%"), vim.fn.line("."))
  else
    cmd = string.format('silent ! kdesvn exec blame %s &', vim.fn.expand("%"))
  end
  vim.cmd(cmd)
end

M.svn_update = function()
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:update /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  else
    cmd = string.format('silent ! kdesvn exec update %s &', utils.rootdir())
  end
  vim.cmd(cmd)
end

M.svn_commit = function()
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:commit /path:\"%s\" /notempfile /closeonend\"', utils.rootdir())
  else
    cmd = string.format('silent ! kdesvn exec commit %s &', utils.rootdir())
  end
  vim.cmd(cmd)
end

M.svn_add_current_file = function()
  local cmd
  if vim.fn.has('win32') == 1 then
    cmd = string.format('silent !\"D:\\Program Files\\TortoiseSVN\\bin\\TortoiseProc.exe\"  /command:add /path:\"%s\" /notempfile /closeonend\"', vim.fn.expand("%"))
  else
    cmd = string.format('silent ! kdesvn exec add %s &', vim.fn.expand("%"))
  end
  vim.cmd(cmd)
end

return M
