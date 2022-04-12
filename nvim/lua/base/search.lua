local utils = require('base.utils')

local M = {}

local function rootdir() return vim.call('asyncrun#get_root', '%') end

M.project_files = function() require('telescope.builtin').find_files({cwd = rootdir()}) end

M.project_tree = function()
  vim.cmd(string.format("silent NvimTreeToggle"))
end

M.project_current_symbols = function()
  require('telescope.builtin').live_grep({cwd = rootdir()})
end

M.project_live_symbols = function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({cwd = rootdir()})
end

M.project_lsp_ref = function()
  require('telescope.builtin').lsp_references({cwd = rootdir()})
end

M.project_symbol_at_point = function()
  require('telescope.builtin').grep_string({cwd = rootdir()})
end

M.current_buffer_symbol_at_point = function()
  require('telescope.builtin').grep_string({search_dirs = {vim.fn.expand('%')}})
end

M.directory_live_symbol = function()
  require('telescope.builtin').live_grep({cwd = '.'})
end

M.file_browser = function()
  require('telescope').extensions.file_browser.file_browser({path = utils.current_dir()}) 
end

M.lsp_document_symbols = function()
  require('telescope.builtin').lsp_document_symbols({symbol_width = 70, symbol_type_width = 15, ignore_filename = true}) 
end


M.oldfiles = function()
  require('telescope.builtin').oldfiles() 
end

M.project_oldfiles = function()
  local opt = {
    cwd_only = true,
    hidden = true
  }
  require('telescope.builtin').oldfiles(opt) 
end


return M
