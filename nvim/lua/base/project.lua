local M = {}

-- 向上找项目根（.projectile / .git），找不到就用当前目录
function M.root()
  return vim.fs.root(0, { ".projectile", ".git" }) or vim.fn.getcwd()
end

-- 列出 ~/workspace 下带 .projectile 标记的项目，选一个切过去
function M.switch()
  local cmd = string.format(
    "fd -t f -H -d 4 '^\\.projectile$' %s 2>/dev/null",
    vim.fn.shellescape(vim.fn.expand("~/workspace"))
  )
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
