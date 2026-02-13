local function im_select()
  if vim.fn.has("win32") == 1 then
    vim.fn.system("im-select 1033")
  elseif vim.fn.has("wsl") == 1 then
    vim.fn.system("/mnt/c/Windows/System32/im-select.exe 1033")
  end
end

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("im_grp", { clear = true }),
  callback = function()
    if vim.bo.filetype == "lua" then
      im_select()
    end
  end,
})
