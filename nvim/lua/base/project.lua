local M = {}

function M.root()
  return vim.fs.root(0, { ".projectile", ".git" }) or vim.fn.getcwd()
end

function M.switch()
  if vim.fn.executable("fd") == 0 then
    vim.notify("未找到 fd，无法枚举 ~/workspace 下的项目", vim.log.levels.WARN)
    return
  end
  local cmd = { "fd", "-t", "f", "-H", "-d", "4", "^\\.projectile$", vim.fn.expand("~/workspace") }
  local projects = {}
  for _, f in ipairs(vim.fn.systemlist(cmd)) do
    table.insert(projects, vim.fn.fnamemodify(f, ":h"))
  end
  if #projects == 0 then
    vim.notify("~/workspace 下没有找到带 .projectile 的项目", vim.log.levels.WARN)
    return
  end
  table.sort(projects)
  vim.ui.select(projects, { prompt = "切换项目" }, function(dir)
    if dir then
      vim.cmd("cd " .. vim.fn.fnameescape(dir))
    end
  end)
end

return M
