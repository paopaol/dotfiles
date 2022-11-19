local utils = require('base.utils')
local strings = require "plenary.strings"
local entry_display = require "telescope.pickers.entry_display"
local Path = require "plenary.path"
local tutils = require "telescope.utils"
local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local Path = require "plenary.path"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local p_window = require "telescope.pickers.window"
local sorters = require "telescope.sorters"
local state = require "telescope.state"

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

function T.gen_from_lsp_location(opts)
  local lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
  }
  opts = opts or {}

  local mt_file_entry = {}

  mt_file_entry.cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
  mt_file_entry.display = function(entry)
    local filename = entry.value.filename
    local basename = vim.fn.fnamemodify(filename, ":t")

    local displayer = entry_display.create {
      separator = " | ",
      items = { { width = 50 }, { width = 300 }, { remaining = true } }
    }

    local hl_group
    basename, hl_group = tutils.transform_devicons(filename, basename, false)
    return displayer { { basename, hl_group }, entry.value.text }
  end

  mt_file_entry.__index = function(t, k)
    local raw = rawget(mt_file_entry, k)
    if raw then
      return raw
    end

    return rawget(t, rawget(lookup_keys, k))
  end

  return function(entry)
    return setmetatable({
      filename = entry.filename,
      lnum = entry.lnum,
      ordinal =  entry.text,
      value = entry
    }, mt_file_entry)
  end
end

local function apply_cwd_only_aliases(opts)
  local has_cwd_only = opts.cwd_only ~= nil
  local has_only_cwd = opts.only_cwd ~= nil

  if has_only_cwd and not has_cwd_only then
    -- Internally, use cwd_only
    opts.cwd_only = opts.only_cwd
    opts.only_cwd = nil
  end

  return opts
end

local function project_buffers(opts)
  local conf = require("telescope.config").values
  local filter = vim.tbl_filter
  opts = apply_cwd_only_aliases(opts)
  local bufnrs = filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
      return false
    end
    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      return false
    end
    if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())
  if not next(bufnrs) then
    return
  end
  if opts.sort_mru then
    table.sort(bufnrs, function(a, b)
      return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
    end)
  end

  local buffers = {}
  local default_selection_idx = 1
  for _, bufnr in ipairs(bufnrs) do

    local fullname = string.lower(vim.api.nvim_buf_get_name(bufnr))
    local root = string.lower(rootdir())
    if string.find(fullname, root) ~= 1 then
      goto continue
    end

    local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

    if opts.sort_lastused and not opts.ignore_current_buffer and flag == "#" then
      default_selection_idx = 2
    end

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    if opts.sort_lastused and (flag == "#" or flag == "%") then
      local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
      table.insert(buffers, idx, element)
    else
      table.insert(buffers, element)
    end
    ::continue::
  end

  if not opts.bufnr_width then
    local max_bufnr = math.max(unpack(bufnrs))
    opts.bufnr_width = #tostring(max_bufnr)
  end

  pickers.new(opts, {
    prompt_title = "Buffers",
    finder = finders.new_table {
      results = buffers,
      entry_maker = opts.entry_maker or make_entry.gen_from_buffer(opts),
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
    default_selection_index = default_selection_idx,
  }):find()
end

M.project_files = function()
  require('telescope.builtin').find_files({ cwd = rootdir(), push_cursor_on_edit = true })
end

M.project_tree = function() vim.cmd(string.format("silent NvimTreeToggle %s", rootdir())) end

M.project_current_symbols = function()
  require('telescope.builtin').live_grep({ cwd = rootdir(), push_cursor_on_edit = true })
end

M.project_live_symbols = function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({ cwd = rootdir(), push_cursor_on_edit = true })
end

M.project_lsp_ref = function()
  require('telescope.builtin').lsp_references({ cwd = rootdir(), entry_maker = T.gen_from_lsp_location(),
  push_cursor_on_edit = true })
end

M.project_symbol_at_point = function()
  require('telescope.builtin').grep_string({ cwd = rootdir(), push_cursor_on_edit = true })
end

M.current_buffer_symbol_at_point = function()
  require('telescope.builtin').grep_string({ search_dirs = { vim.fn.expand('%') }, push_cursor_on_edit = true })
end

M.directory_live_symbol = function()
  require('telescope.builtin').live_grep({ cwd = '.', push_cursor_on_edit = true })
end

M.search_current_buffer = function()
  require('telescope.builtin').current_buffer_fuzzy_find({ push_cursor_on_edit = true })
end

M.file_browser = function()
  require('telescope').extensions.file_browser.file_browser({
    path = utils.current_dir(),
    grouped = true
  })
end

M.lsp_document_symbols = function()
  require('telescope.builtin').lsp_document_symbols({
    symbol_width = 70,
    symbol_type_width = 15,
    ignore_filename = true,
    push_cursor_on_edit = true
  })
end

M.oldfiles = function()
  local opt = { hidden = true, entry_maker = T.gen_from_file(), push_cursor_on_edit = true }
  require('telescope.builtin').oldfiles(opt)
end

M.project_oldfiles = function()
  local opt = { cwd_only = true, hidden = true, entry_maker = T.gen_from_file(), push_cursor_on_edit = true }
  require('telescope.builtin').oldfiles(opt)
end

M.buffers = function()
  local opt = { cwd = rootdir(), show_all_buffers = false, entry_maker = T.gen_from_buffer(), push_cursor_on_edit = true }
  require('telescope.builtin').buffers(opt)
end

M.lsp_calltree = function()
  vim.lsp.buf.incoming_calls()
end


M.project_buffers = function()
  local opt = { cwd = rootdir(), show_all_buffers = false, entry_maker = T.gen_from_buffer() }
  project_buffers(opt)
end

local exploer_dir = function(dir)
  if vim.fn.has('win32') then
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

M.man = function()
  local opt = { sections = { "ALL" } }
  require('telescope.builtin').man_pages(opt)
end



return M
