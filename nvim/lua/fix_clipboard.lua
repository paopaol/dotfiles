local A = vim.api
local M = {}

local augroup = vim.api.nvim_create_augroup("deferClip", {})

local entries = {
  first = 1,
  last = 1,
}
local active_entry = {}


local function add_entry(entry)
  entries[entries.last] = entry
  entries.last = entries.last + 1
end

local function pop_entry()
  if entries.first < entries.last then
    local entry = entries[entries.first]
    entries[entries.first] = nil
    entries.first = entries.first + 1
    return entry
  end
end

local function sync_from()
  vim.fn.jobstart({ "win32yank", "-o", "--lf" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      vim.fn.setreg("-", data, "v")
      active_entry = { lines = data, regtype = "v" }
    end,
  })
end

local sync_to
do
  local cur_sync_job
  local function sync_next(entry)
    local chan = vim.fn.jobstart({ "win32yank", "-i" }, {
      on_exit = function(_)
        local next_entry = pop_entry()
        if next_entry then
          sync_next(next_entry)
        else
          cur_sync_job = nil
        end
      end,
    })
    cur_sync_job = chan

    vim.fn.chansend(chan, entry.lines)
    vim.fn.chanclose(chan, "stdin")
  end


  sync_to = function()
    if cur_sync_job then
      return
    else
      local entry = pop_entry()

      if entry then
        sync_next(entry)
      end
    end
  end
end


function M.copy(lines, regtype)
  add_entry({ lines = lines, regtype = regtype })
  active_entry = { lines = lines, regtype = regtype }
  sync_to()
end

function M.get_active()
  return { active_entry.lines, active_entry.regtype }
end

function M.setup()
  if vim.g.neovide == true then
    vim.o.mouse = ""
    vim.keymap.set({ "n", "v", "i" }, "<C-S-v>", function()
      vim.cmd([[normal! "-p]])
    end)
  end
  vim.api.nvim_exec(
    [[
    function s:copy(lines, regtype)
      call luaeval('require("fix_clipboard").copy(_A[1], _A[2])', [a:lines, a:regtype])
    endfunction
    function s:get_active()
      call luaeval('require("fix_clipboard").get_active()')
    endfunction

    let g:clipboard = {
          \   'name': 'deferClip',
          \   'copy': {
          \      '+': {lines, regtype -> s:copy(lines, regtype)},
          \      '*': {lines, regtype -> s:copy(lines, regtype)},
          \    },
          \   'paste': {
          \      '+': {-> s:get_active()},
          \      '*': {-> s:get_active()},
          \   },
          \ }

  ]],

    false
  )
  vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    group = augroup,
    callback = sync_from,
  })
end

return M
