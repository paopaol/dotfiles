
local M = {}

M.SubProjectFiles = function()
    require("telescope.builtin").fd({cwd = vim.fn.expand('%:h')})
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

-- "跳转到函数的参数"
function M.jumpright()
    local save_cursor = vim.fn.getcurpos()
    vim.cmd([[SidewaysJumpRight]])
    local cur_cursor = vim.fn.getcurpos()
    if save_cursor[2] ~= cur_cursor[2] or save_cursor[3] ~= cur_cursor[3] then
        return
    end

    vim.fn.setpos('.', {0 , vim.fn.line('.'), 0})
    local match_num = vim.fn.search('(', 'n', vim.fn.line('.'))
    if match_num == 0 then
        return
    end

    vim.fn. search('(', '', vim.fn.line('.'))
    local content = vim.fn.getline('.')
    local idx = vim.fn.stridx(content, "(")
    if idx < 0 then
        return
    end
    local current = vim.fn.getcurpos()
    current[3]  = current[3] + 1
    vim.fn.setpos('.', current)
end

return M
