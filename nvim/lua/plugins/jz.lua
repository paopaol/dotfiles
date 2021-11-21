local fzf = require('fzf-lua')

local M = {}

local function project_current_project_dir(dir)
  dir = dir or vim.fn.expand('%', ":p:h")
  dir = vim.fn.fnamemodify(dir, ':p:h')

  local found = vim.fn.readdir(dir, function(n)
    local f = string.match(n, '.pro$')
    return f ~= nil
  end)

  if next(found) ~= nil then return dir end

  dir = vim.fn.fnamemodify(dir, ':h')
  if dir == '/' then return nil end

  return project_current_project_dir(dir)
end

M.SubProjectFiles = function()
  local dir = project_current_project_dir()
  print(dir)
  fzf.my_files({cwd = dir})
end

--------------------------

local filter_buffers = function(opts, unfiltered)
  local curtab_bufnrs = {}

  local excluded = {}
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then excluded[b] = true end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
      excluded[b] = true
    end
    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      excluded[b] = true
    end
    if opts.current_tab_only and not curtab_bufnrs[b] then excluded[b] = true end
    if opts.no_term_buffers and utils.is_term_buffer(b) then
      excluded[b] = true
    end
    if opts.cwd_only and
        not path.is_relative(vim.api.nvim_buf_get_name(b), vim.loop.cwd()) then
      excluded[b] = true
    end
    return not excluded[b]
  end, unfiltered)

  return bufnrs, excluded
end

-- local width = vim.api.nvim_win_get_width(0)
-- local height = vim.api.nvim_win_get_height(0)
-- local pos = vim.api.nvim_win_get_position(0)
-- vim.api.nvim_win_set_buf(0, bufnr)
-- print(vim.inspect(vim.api.nvim_list_bufs()))
-- nvim_win_get_config(0)   
local function all_winnr() return vim.api.nvim_tabpage_list_wins(0) end

local function is_current_buf_loaded_other_window()
  local current_bufnr = vim.fn.bufnr('%')
  local current_winnr = vim.fn.winnr()

  local all = all_winnr()

  for _, winid in pairs(all) do
    local win_nr = vim.api.nvim_win_get_number(winid)

    if win_nr ~= current_winnr then
      local attached_bufnr = vim.api.nvim_win_get_buf(winid)
      if current_bufnr == attached_bufnr then return true end
    end
  end
  return nil
end

function M.close_current_buffer()
  local list = filter_buffers({}, vim.api.nvim_list_bufs())

  local ft = vim.api.nvim_buf_get_option(0, 'ft')
  if ft == "FALLBACK" then
    print("can't close fallback buffer")
    return
  end

  if not next(list) then return end

  local curr_bufnr = vim.fn.bufnr('%')
  local need_force_delete
  if not is_current_buf_loaded_other_window() then need_force_delete = true end

  if #list > 1 then vim.cmd('BufSurfBack') end
  if need_force_delete then
    vim.api.nvim_buf_delete(curr_bufnr, {force = true})
    return
  end

  if #list == 1 then
    local bufnr = vim.fn.bufnr('Scratch', 1)
    vim.api.nvim_win_set_buf(0, bufnr)
    vim.o.ft = "FALLBACK"
  end
end

return M
