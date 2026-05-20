vim.treesitter.start()

if vim.bo.modifiable then
  vim.opt_local.fileformat = "dos"
end
