local M = {}

function M.is_buffer_empty()
  -- Check whether the current buffer is empty
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end

function M.open_current_file_use_qtcreator()
  vim.cmd(string.format("silent ! qtcreator -client %s &", vim.fn.expand("%")))
end

function M.uncolor_all_words()
  vim.fn.UncolorAllWords()
  vim.g.nohlsearch = true
end

function M.rootdir() return vim.call('asyncrun#get_root', '%') end

return M
