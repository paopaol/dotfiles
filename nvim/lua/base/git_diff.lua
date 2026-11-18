-- 复刻 telescope-git-diffs：git log --graph 列表，选出 1/2 个 commit 交给 diffview

-- 取提交时间，用于把选中的 commit 排成旧 -> 新
local function commit_time(item)
  local out = vim.fn.systemlist({ "git", "-C", item.cwd or ".", "show", "-s", "--format=%ct", item.commit })
  return tonumber(out and out[1]) or 0
end

local function finder(_, ctx)
  -- 用到时才 require，避免 base.search 加载时连带拉起初未加载的 snacks
  local Proc = require("snacks.picker.source.proc")
  local cwd = require("snacks").git.get_root() or vim.fn.getcwd()
  return function(cb)
    Proc.proc({
      cmd = "git",
      cwd = cwd,
      args = { "log", "--graph", "--oneline", "--decorate", "--all", "." },
      transform = function(item)
        -- 从 graph 行里取出 hash；分支连接线（|\）没有 hash，丢弃
        local commit = item.text:match("^[%*%|\\/ ]*([0-9a-f]+) ")
        if not commit then
          return false
        end
        item.commit = commit
        item.cwd = cwd
        return item
      end,
    }, ctx)(cb)
  end
end

return function()
  require("snacks").picker.pick({
    title = "Git Diff Commits",
    finder = finder,
    format = "text",
    -- 原配置 enable_preview_diff = false：只预览 commit 信息，不预览整段 diff
    preview = "git_log",
    confirm = function(p, item)
      local sel = p:selected()
      if #sel > 2 then
        vim.notify("最多选择 1 或 2 个 commit", vim.log.levels.WARN)
        return
      end
      if #sel == 0 then
        if not item then
          return
        end
        sel = { item }
      end
      table.sort(sel, function(a, b)
        return commit_time(a) < commit_time(b)
      end)
      p:close()
      if #sel == 2 then
        vim.cmd(("DiffviewOpen %s..%s"):format(sel[1].commit, sel[2].commit))
      else
        vim.cmd(("DiffviewOpen %s^!"):format(sel[1].commit))
      end
      vim.cmd("stopinsert")
    end,
  })
end
