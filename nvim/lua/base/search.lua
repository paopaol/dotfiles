local M = {}

local function rootdir()
  return vim.call("asyncrun#get_root", "%")
end

local function picker()
  return require("snacks").picker
end

-- 项目内
M.project_files = function()
  picker().files({ cwd = rootdir() })
end

M.project_current_symbols = function()
  picker().grep({ cwd = rootdir() })
end

M.project_live_symbols = function()
  picker().lsp_workspace_symbols({ cwd = rootdir() })
end

M.project_symbol_at_point = function()
  picker().grep_word({ cwd = rootdir() })
end

M.project_lsp_ref = function()
  picker().lsp_references({ cwd = rootdir() })
end

M.project_oldfiles = function()
  picker().recent({ filter = { cwd = rootdir() } })
end

M.project_buffers = function()
  picker().buffers({ filter = { cwd = rootdir() } })
end

M.project_diagnostics = function()
  picker().diagnostics({ filter = { cwd = rootdir() } })
end

-- 当前目录/文件
M.directory_live_symbol = function()
  picker().grep({ cwd = "." })
end

M.current_buffer_symbol_at_point = function()
  picker().grep_word({ dirs = { vim.fn.expand("%") } })
end

M.search_current_buffer = function()
  local file_path = vim.api.nvim_buf_get_name(0)
  if vim.api.nvim_buf_line_count(0) > 10000 and file_path ~= "" then
    -- 大文件改走文件内 grep，避免预览卡顿
    picker().grep({ dirs = { file_path } })
  else
    picker().lines()
  end
end

-- 符号/跳转
M.lsp_document_symbols = function()
  picker().lsp_symbols()
end

M.lsp_definition = function()
  picker().lsp_definitions()
end

-- 列表
M.buffers = function()
  picker().buffers({ sort_lastused = true })
end

M.oldfiles = function()
  picker().recent()
end

M.man = function()
  picker().man()
end

M.vim_book_marks = function()
  local items = {}
  for _, file in ipairs(vim.fn["bm#all_files"]()) do
    for _, line in ipairs(vim.fn["bm#all_lines"](file)) do
      local bm = vim.fn["bm#get_bookmark_by_line"](file, line)
      items[#items + 1] = {
        file = file,
        pos = { tonumber(line), 0 },
        text = bm.annotation ~= "" and bm.annotation or bm.content,
      }
    end
  end
  picker().pick({ title = "Bookmarks", items = items })
end

M.filetypes = function()
  local items = {}
  for _, ft in ipairs(vim.fn.getcompletion("", "filetype")) do
    items[#items + 1] = { text = ft }
  end
  picker().pick({
    title = "Filetypes",
    items = items,
    confirm = function(p, item)
      p:close()
      if item then
        vim.bo.filetype = item.text
      end
    end,
  })
end

M.colorschemes = function()
  picker().colorschemes()
end

-- 复刻 telescope-git-diffs，实现见 base/git_diff.lua
M.git_diff = require("base.git_diff")

M.document_diagnostics = function()
  picker().diagnostics_buffer()
end

-- Neotree
M.project_tree = function()
  vim.cmd(string.format("silent :Neotree action=focus  position=left toggle=true %s", rootdir()))
end

M.project_tree_focus = function()
  vim.cmd(string.format("silent :Neotree action=focus  position=left toggle=true reveal %s", rootdir()))
end

M.lsp_calltree = function()
  vim.lsp.buf.incoming_calls()
end

local exploer_dir = function(dir)
  if vim.fn.has("win32") then
    vim.cmd("silent !start " .. dir)
  end
end

M.exploer_dir_project = function()
  exploer_dir(rootdir())
end

M.exploer_dir_current = function()
  exploer_dir(vim.fn.expand("%:p:h", nil, nil))
end

M.open_with_defualt = function()
  exploer_dir(vim.fn.expand("%", nil, nil))
end

M.extract = function()
  local r = vim.lsp.util.make_given_range_params()
  local line1 = r.range.start.line + 1
  local line2 = r.range["end"].line + 1
  vim.lsp.buf.code_action({ range = { start = { line1, 0 }, ["end"] = { line2, 0 } } })
end

return M
