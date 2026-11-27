local jz_layout = {
  backdrop = false,
  width = 0.99,
  height = function()
    return vim.o.lines - vim.o.cmdheight
  end,
  box = "vertical",
  {
    win = "preview",
    height = 0.6,
    border = "rounded",
    title = " {title} {live} {flags}",
    title_pos = "left",
  },
  { win = "input", height = 1, border = "top" },
  { win = "list", border = "none" },
}

-- select 小窗在光标下方展开，保留 source 的 config
local function setup_select_layout(opts)
  local win = vim.api.nvim_get_current_win()
  local info = vim.fn.getwininfo(win)[1] or {}
  local row = (info.winrow or 1) + vim.fn.winline() - 1
  local col = (info.wincol or 1) + vim.fn.wincol() - 2
  opts.layout = {
    preset = "select",
    config = opts.layout.config,
    layout = { relative = "editor", row = row, col = col },
  }
end

-- expr 映射返回键码会被字面插入，故用 feedkeys 模拟按键
local function emit(k)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), "n", false)
end

-- 固定当前结果子集，清空输入后继续在子集内过滤
local function refine(picker)
  local items = picker.list and picker.list.items or {}
  if #items == 0 then
    return
  end
  picker.finder._find = function()
    return items
  end
  picker.finder.filter = nil -- 强制重跑 finder（用上面固定的结果）
  picker.opts.live = false -- live picker（grep）后续输入改走本地过滤，不再重跑搜索
  picker.input:set("", "")
  picker:find()
end

-- helm 式特化：输入行左侧显示当前目录，C-w 空输入回上级
local function setup_file_browser(opts)
  if type(opts.title) ~= "string" or not opts.title:match("^File Browser: (.*)$") then
    return
  end

  -- statuscolumn 会被 nvim 按窗口宽度截断（路径开头变 "<..."），
  -- 改为把路径显示在输入窗口的上边框 title，宽度是整个窗口，update_titles 自动刷新
  opts.prompt = ""
  if opts.layout and opts.layout.layout then
    for _, w in ipairs(opts.layout.layout) do
      if w.win == "input" then
        w.title = " {source} "
        w.title_pos = "left"
      end
    end
  end
  opts.format = function(item, picker)
    if item.text == "../" then
      return { { "..", "SnacksPickerDirectory" } }
    end
    return require("snacks").picker.format.file(item, picker)
  end
  opts.actions = opts.actions or {}
  opts.actions.helm_back = function(picker)
    local line = picker.input:get()
    if line == "" then
      picker:action("browse_back")
    else
      picker.input:set((line:gsub("%s*[^%s]*$", "")))
    end
  end
  opts.win = opts.win or {}
  opts.win.input = opts.win.input or {}
  opts.win.input.keys = opts.win.input.keys or {}
  opts.win.input.keys["<C-w>"] = { "back", mode = { "n", "i" } }
  -- snacks 默认的大写 <C-W> 与上面的 C-w 归一化后同名，保留会报 duplicate key
  opts.win.input.keys["<C-W>"] = false
end

-- 避免过滤到少量结果时列表变空白
local function disable_list_pause(opts)
  local on_show = opts.on_show
  opts.on_show = function(picker)
    picker.list.pause = function() end
    if on_show then
      on_show(picker)
    end
  end
end

return {
  picker = {
    -- 自定义 action 需注册在 actions 里、键位用字符串引用（直接写函数拿到的是 Window 对象）
    actions = {
      refine = refine,
      input_home = function()
        emit("<Home>")
      end,
      input_left = function()
        emit("<Left>")
      end,
    },
    layout = { layout = jz_layout },
    -- 覆盖 source 自带的布局（lines/explorer 的 ivy/sidebar/vscode）
    config = function(opts)
      if opts.layout and opts.layout.preset == "select" then
        setup_select_layout(opts)
      else
        opts.layout = { layout = vim.deepcopy(jz_layout) }
      end
      setup_file_browser(opts)
      disable_list_pause(opts)
      return opts
    end,
    matcher = { fuzzy = false, smartcase = false, ignorecase = true },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "cancel", mode = { "n", "i" } },
          ["<C-j>"] = { "list_down", mode = { "i", "n" } },
          ["<C-k>"] = { "list_up", mode = { "i", "n" } },
          ["<C-h>"] = { "toggle_help_input", mode = { "i", "n" } },
          -- 覆盖 snacks 默认的 C-a 全选、C-b 预览上滚
          ["<C-a>"] = { "input_home", mode = { "i" } },
          ["<C-b>"] = { "input_left", mode = { "i" } },
          ["<C-f>"] = { "refine", mode = { "i", "n" } },
          ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          -- A-q 备用，防终端吞 C-q
          ["<C-q>"] = { "qflist", mode = { "i", "n" } },
          ["<A-q>"] = { "qflist", mode = { "i", "n" } },
        },
      },
      list = {
        keys = {
          ["<Esc>"] = "cancel",
          ["<C-d>"] = { "preview_scroll_down", mode = { "n", "x" } },
          ["<C-u>"] = { "preview_scroll_up", mode = { "n", "x" } },
          ["<C-q>"] = { "qflist", mode = { "n", "x" } },
          ["<A-q>"] = { "qflist", mode = { "n", "x" } },
        },
      },
    },
    sources = {
      files = {
        exclude = { "*.o", "*.so*", "*.o.d" },
      },
    },
  },
}
