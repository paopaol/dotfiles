local utils = require('base.utils')
local strings = require "plenary.strings"
local entry_display = require "telescope.pickers.entry_display"
local Path = require "plenary.path"
local tutils = require "telescope.utils"

local M = {}

local function rootdir() return vim.call('asyncrun#get_root', '%') end

local T = {}

do
  local lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
  }

  function T.gen_from_file(opts)
    opts = opts or {}

    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

    local mt_file_entry = {}

    mt_file_entry.cwd = cwd
    mt_file_entry.display = function(entry)
      local basename = vim.fn.fnamemodify(entry.value, ":t")
      local dir = vim.fn.fnamemodify(entry.value, ":p:h")

      if basename == "" then basename = "[No Name]" end

      local displayer = entry_display.create {
        separator = " | ",
        items = { { width = 50 }, { width = 300 }, { remaining = true } }
      }

      if basename == "" then basename = "[No Name]" end

      local hl_group
      basename, hl_group = tutils.transform_devicons(entry.value, basename, false)
      return displayer { { basename, hl_group }, dir }
    end

    mt_file_entry.__index = function(t, k)
      local raw = rawget(mt_file_entry, k)
      if raw then
        return raw
      end

      if k == "path" then
        local retpath = Path:new({ t.cwd, t.value }):absolute()
        if not vim.loop.fs_access(retpath, "R", nil) then
          retpath = t.value
        end
        return retpath
      end

      return rawget(t, rawget(lookup_keys, k))
    end

    return function(line)
      return setmetatable({ line }, mt_file_entry)
    end
  end
end

function T.gen_from_buffer(opts)
  opts = opts or {}

  local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

  local make_display = function(entry)
    local basename = vim.fn.fnamemodify(entry.value, ":t")
    local dir = vim.fn.fnamemodify(entry.value, ":p:h")

    if basename == "" then basename = "[No Name]" end

    local displayer = entry_display.create {
      separator = " | ",
      items = { { width = 50 }, { width = 300 }, { remaining = true } }
    }

    if basename == "" then basename = "[No Name]" end

    local hl_group
    basename, hl_group = tutils.transform_devicons(entry.value, basename, false)
    return displayer { { basename, hl_group }, dir }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    -- if bufname is inside the cwd, trim that part of the string
    bufname = Path:new(bufname):normalize(cwd)

    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed
    local line_count = vim.api.nvim_buf_line_count(entry.bufnr)


    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. bufname,
      display = make_display,

      bufnr = entry.bufnr,
      filename = bufname,
      -- account for potentially stale lnum as getbufinfo might not be updated or from resuming buffers picker
      lnum = entry.info.lnum ~= 0 and math.max(math.min(entry.info.lnum, line_count), 1) or 1,
      indicator = indicator,
    }
  end
end

M.project_files = function()
  require('telescope.builtin').find_files({ cwd = rootdir() })
end

M.project_tree = function() vim.cmd(string.format("silent NvimTreeToggle")) end

M.project_current_symbols = function()
  require('telescope.builtin').live_grep({ cwd = rootdir() })
end

M.project_live_symbols = function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({ cwd = rootdir() })
end

M.project_lsp_ref = function()
  require('telescope.builtin').lsp_references({ cwd = rootdir() })
end

M.project_symbol_at_point = function()
  require('telescope.builtin').grep_string({ cwd = rootdir() })
end

M.current_buffer_symbol_at_point = function()
  require('telescope.builtin').grep_string({ search_dirs = { vim.fn.expand('%') } })
end

M.directory_live_symbol = function()
  require('telescope.builtin').live_grep({ cwd = '.' })
end

M.file_browser = function()
  require('telescope').extensions.file_browser.file_browser({
    path = utils.current_dir()
  })
end

M.lsp_document_symbols = function()
  require('telescope.builtin').lsp_document_symbols({
    symbol_width = 70,
    symbol_type_width = 15,
    ignore_filename = true
  })
end

M.oldfiles = function()
  local opt = { hidden = true, entry_maker = T.gen_from_file() }
  require('telescope.builtin').oldfiles(opt)
end

M.project_oldfiles = function()
  local opt = { cwd_only = true, hidden = true, entry_maker = T.gen_from_file() }
  require('telescope.builtin').oldfiles(opt)
end

M.buffers = function()
  local opt = { cwd = rootdir(), show_all_buffers = false, entry_maker = T.gen_from_buffer() }
  require('telescope.builtin').buffers(opt)
end

M.lsp_calltree = function()
  vim.lsp.buf.incoming_calls()
end

return M
