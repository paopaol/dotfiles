-- 只启用 picker 模块，其余模块保持关闭

-- 全宽全高：预览上 60%，输入居中，候选在下
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

-- 同 telescope C-f：固定当前过滤结果，清空输入后在子集内继续过滤
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

-- 在输入行里模拟一个按键（expr 映射返回键码会被字面插入，这里用 feedkeys）
local function emit(k)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(k, true, false, true), "n", false)
end

-- snacks-file-browser 的 helm 式特化：当前目录显示在输入行左侧，C-w 空输入回上级
local function setup_file_browser(opts)
  if type(opts.title) ~= "string" then
    return
  end
  local dir = opts.title:match("^File Browser: (.*)$")
  if not dir then
    return
  end

  local function prompt(path)
    return " " .. path .. " "
  end

  opts.prompt = prompt(dir)
  -- 上级目录项的 file 是 cwd 外的绝对路径，默认按 file 渲染会变成 "󰉋 ~/workspace/jz"
  opts.format = function(item, picker)
    if item.text == "../" then
      return { { "../", "SnacksPickerDirectory" } }
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
  opts.win.input.keys["<C-w>"] = { "helm_back", mode = { "n", "i" } }
  -- snacks 默认的大写 <C-W> 与上面的 C-w 归一化后同名，保留会报 duplicate key
  opts.win.input.keys["<C-W>"] = false

  return prompt
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
        -- select 小窗：恢复小布局，并在光标下方展开
        local win = vim.api.nvim_get_current_win()
        local info = vim.fn.getwininfo(win)[1] or {}
        local row = (info.winrow or 1) + vim.fn.winline() - 1
        local col = (info.wincol or 1) + vim.fn.wincol() - 2
        opts.layout = {
          preset = "select",
          config = opts.layout.config,
          layout = { relative = "editor", row = row, col = col },
        }
      else
        opts.layout = { layout = vim.deepcopy(jz_layout) }
      end
      local prompt = setup_file_browser(opts)

      -- 禁用列表暂停，避免过滤到少量结果时列表空白
      local on_show = opts.on_show
      opts.on_show = function(picker)
        picker.list.pause = function() end
        if prompt and not picker._helm_prompt then
          picker._helm_prompt = true
          -- 插件换目录只改 picker.title，这里把新目录同步到输入行 prompt
          local update_titles = picker.update_titles
          picker.update_titles = function(self, ...)
            local dir = type(self.title) == "string" and self.title:match("^File Browser: (.*)$")
            if dir then
              self.opts.prompt = prompt(dir)
              self.input:update()
            end
            return update_titles(self, ...)
          end
        end
        if on_show then
          on_show(picker)
        end
      end
      return opts
    end,
    -- 精确子串匹配，但不等大小写：输入 getValue 也能命中 GetValue
    matcher = { fuzzy = false, smartcase = false, ignorecase = true },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "cancel", mode = { "n", "i" } },
          ["<C-j>"] = { "list_down", mode = { "i", "n" } },
          ["<C-k>"] = { "list_up", mode = { "i", "n" } },
          ["<C-h>"] = { "toggle_help_input", mode = { "i", "n" } },
          -- C-a 行首、C-b 左移（snacks 默认是全部选中 / 预览上滚）
          ["<C-a>"] = { "input_home", mode = { "i" } },
          ["<C-b>"] = { "input_left", mode = { "i" } },
          -- 固定当前结果子集后清空输入，继续过滤（同 telescope C-f）
          ["<C-f>"] = { "refine", mode = { "i", "n" } },
          -- 预览区上下滚动（同 telescope）
          ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          -- 选中项送 quickfix，A-q 备用（防终端吞键）
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
