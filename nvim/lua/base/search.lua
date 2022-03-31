local M = {}

local function rootdir() return vim.call('asyncrun#get_root', '%') end

M.project_files = function() require('fzf-lua').my_files({cwd = rootdir()}) end

M.project_tree = function()
  vim.cmd(string.format("silent NERDTreeToggle %s", rootdir()))
end

M.project_current_symbols = function()
  require('fzf-lua').live_grep_native({cwd = rootdir()})
end

M.project_live_symbols = function()
  require('fzf-lua').lsp_live_workspace_symbols({cwd = rootdir()})
end

M.project_lsp_ref = function()
  require('fzf-lua').lsp_references({cwd = rootdir()})
end

M.project_symbol_at_point = function()
  require('fzf-lua').grep_cword({cwd = rootdir()})
end

M.directory_live_symbol = function()
  require('fzf-lua').live_grep_native({cwd = '.'})
end

return M
