function _G.im_select()
  if vim.fn.has('win32') == 1 then
    vim.fn.system('im-select 1033')
  elseif vim.fn.has('wsl') == 1 then
    vim.fn.system('/mnt/c/Windows/System32/im-select.exe 1033')
  end
end

vim.cmd([[
  autocmd InsertLeave * lua im_select()
]])
