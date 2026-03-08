-- Nightfox Classic Theme Configuration
-- 基于 Qt Creator Default Classic 主题配色
-- 使用方法：在 Neovim 配置中使用 require("nightfox-classic")

local nightfox_classic = {}

-- 基于 Qt Creator Default Classic 的调色板
nightfox_classic.palettes = {
  -- 所有风格的基础调色板
  all = {
    -- 基础颜色定义
    black   = "#000000",
    red     = "#ff0000",
    green   = "#008000",
    yellow  = "#808000",
    blue    = "#0000ff",
    magenta = "#800080",
    cyan    = "#008080",
    white   = "#ffffff",
    orange  = "#ff8000",
    pink    = "#ff0080",
  },

  -- Classic 专用调色板
  classic = {
    -- 基础背景和前景色
    bg0 = "#ffffff",    -- 背景色（深色版本）
    bg1 = "#ffffff",    -- 主要背景
    bg2 = "#f5fafd",    -- 搜索范围背景
    bg3 = "#efebe7",    -- 行号背景
    bg4 = "#efefef",    -- 禁用代码背景

    fg0 = "#000000",    -- 深色前景
    fg1 = "#000000",    -- 主要前景
    fg2 = "#9f9d9a",    -- 行号前景
    fg3 = "#808080",    -- 当前行号前景

    -- 选择和搜索颜色
    sel0 = "#c1ddee",   -- 当前行背景
    sel1 = "#308cc6",   -- 选择背景

    -- 注释颜色
    comment = "#008000",

    -- 自定义颜色
    dark_blue   = "#000080",   -- 数字、预处理器
    dark_red    = "#800000",   -- 字段、标签、绑定
    dark_magenta= "#800080",   -- 类型、静态
    dark_yellow = "#808000",   -- 关键字、属性、基本类型
    olive_green = "#008000",   -- 字符串、注释
    link_blue   = "#0000ff",   -- 链接
    search_bg   = "#ffef0b",   -- 搜索结果背景
    js_scope    = "#2985c7",   -- JS 作用域变量
    js_import   = "#0055af",   -- JS 导入变量
  },
}

-- 规格定义（将调色板映射到逻辑组）
nightfox_classic.specs = {
  all = {
    syntax = {
      keyword     = "dark_yellow",  -- 关键字
      conditional = "dark_yellow",  -- 条件语句
      constant    = "dark_blue",    -- 常量
      number      = "dark_blue",    -- 数字
      float       = "dark_blue",    -- 浮点数
      boolean     = "dark_blue",    -- 布尔值
      string      = "olive_green",  -- 字符串
      character   = "olive_green",  -- 字符
      type        = "dark_magenta", -- 类型
      func        = "fg1",          -- 函数
      variable    = "fg1",          -- 变量
      operator    = "fg1",          -- 操作符
      preproc     = "dark_blue",    -- 预处理器
      include     = "dark_blue",    -- 包含
      define      = "dark_blue",    -- 定义
      macro       = "dark_blue",    -- 宏
      parameter   = "fg1",          -- 参数
      field       = "dark_red",     -- 字段
      property    = "dark_red",     -- 属性
      enum        = "dark_magenta", -- 枚举
      enumConst   = "dark_blue",    -- 枚举常量
      label       = "dark_red",     -- 标签
      todo        = "orange",       -- TODO
    },
    git = {
      add      = "#00aa00",  -- 添加行
      change   = "#ff8000",  -- 修改行
      delete   = "#ff0000",  -- 删除行
      conflict = "#ff0000",  -- 冲突
    },
    diff = {
      add    = "#00aa00",    -- 添加
      change = "#308cc6",    -- 修改
      delete = "#ff0000",    -- 删除
      text   = "#000000",    -- 文本
      add_bg = "#dfffdf",    -- 添加背景
      change_bg = "#c1ddee", -- 修改背景
      delete_bg = "#ffdfdf", -- 删除背景
    },
    diagnostic = {
      error   = "#ff0000",   -- 错误
      warn    = "#ffbe00",   -- 警告
      info    = "#262088",   -- 信息
      hint    = "#308cc6",   -- 提示
      ok      = "#008000",   -- OK
    },
  },

  classic = {
    syntax = {
      keyword = "dark_yellow",
      string  = "olive_green",
    },
  },
}

-- 高亮组定义
nightfox_classic.groups = {
  all = {
    -- 编辑器基础样式
    Normal       = { fg = "fg1", bg = "bg1" },
    NormalFloat  = { fg = "fg1", bg = "bg1" },
    NormalNC     = { fg = "fg1", bg = "bg1" },

    -- 当前行和行号
    CursorLine   = { bg = "sel0" },
    CursorLineNr = { fg = "fg3", bg = "sel0", style = "bold" },
    LineNr       = { fg = "fg2", bg = "bg3" },
    SignColumn   = { fg = "fg2", bg = "bg3" },

    -- 选择和搜索
    Visual       = { fg = "#ffffff", bg = "sel1" },
    VisualNOS    = { fg = "#ffffff", bg = "sel1" },
    Search       = { bg = "search_bg" },
    IncSearch    = { bg = "search_bg" },

    -- 括号匹配
    MatchParen   = { fg = "red", bg = "#b4eeb4" },

    -- 自动补全
    Pmenu        = { fg = "dark_blue", bg = "#c0c0ff" },
    PmenuSel     = { fg = "#ffffff", bg = "sel1" },
    PmenuSbar    = { bg = "#c0c0c0" },
    PmenuThumb   = { bg = "#808080" },

    -- 状态栏
    StatusLine   = { fg = "fg1", bg = "sel0" },
    StatusLineNC = { fg = "fg2", bg = "bg3" },

    -- 标签页
    TabLine      = { fg = "fg2", bg = "bg3" },
    TabLineFill  = { bg = "bg3" },
    TabLineSel   = { fg = "fg1", bg = "sel0", style = "bold" },

    -- 垂直分割线
    VertSplit    = { fg = "#c0c0c0", bg = "bg1" },

    -- 光标
    Cursor       = { fg = "bg1", bg = "fg1" },
    lCursor      = { fg = "bg1", bg = "fg1" },
    CursorIM     = { fg = "bg1", bg = "fg1" },

    -- 折叠
    Folded       = { fg = "fg2", bg = "bg3" },
    FoldColumn   = { fg = "fg2", bg = "bg3" },

    -- 特殊字符
    Whitespace   = { fg = "#c0c0c0" },
    NonText      = { fg = "#c0c0c0" },
    SpecialKey   = { fg = "#c0c0c0" },

    -- 消息
    MsgArea      = { fg = "fg1", bg = "bg1" },
    MsgSeparator = { fg = "fg1", bg = "bg1" },
    MoreMsg      = { fg = "dark_blue", style = "bold" },
    ModeMsg      = { fg = "fg1" },
    Question     = { fg = "olive_green", style = "bold" },
    WarningMsg   = { fg = "orange", style = "bold" },
    ErrorMsg     = { fg = "red", style = "bold" },

    -- 标题
    Title        = { fg = "dark_magenta", style = "bold" },

    -- 差异显示
    DiffAdd      = { fg = "git.add", bg = "diff.add_bg" },
    DiffChange   = { fg = "git.change", bg = "diff.change_bg" },
    DiffDelete   = { fg = "git.delete", bg = "diff.delete_bg" },
    DiffText     = { fg = "diff.text", bg = "#ffff00" },
    DiffAdded    = { fg = "git.add" },
    DiffRemoved  = { fg = "git.delete" },
    DiffFile     = { fg = "dark_blue" },
    DiffIndexLine= { fg = "link_blue" },

    -- 拼写检查
    SpellBad     = { fg = "red", style = "underline" },
    SpellCap     = { fg = "orange", style = "underline" },
    SpellLocal   = { fg = "cyan", style = "underline" },
    SpellRare    = { fg = "dark_magenta", style = "underline" },

    -- 诊断
    DiagnosticError   = { fg = "diagnostic.error" },
    DiagnosticWarn    = { fg = "diagnostic.warn" },
    DiagnosticInfo    = { fg = "diagnostic.info" },
    DiagnosticHint    = { fg = "diagnostic.hint" },
    DiagnosticOk      = { fg = "diagnostic.ok" },
    DiagnosticUnderlineError = { fg = "diagnostic.error", style = "underline" },
    DiagnosticUnderlineWarn  = { fg = "diagnostic.warn", style = "underline" },
    DiagnosticUnderlineInfo  = { fg = "diagnostic.info", style = "underline" },
    DiagnosticUnderlineHint  = { fg = "diagnostic.hint", style = "underline" },
    DiagnosticUnderlineOk    = { fg = "diagnostic.ok", style = "underline" },
    DiagnosticVirtualTextError = { fg = "diagnostic.error" },
    DiagnosticVirtualTextWarn  = { fg = "diagnostic.warn" },
    DiagnosticVirtualTextInfo  = { fg = "diagnostic.info" },
    DiagnosticVirtualTextHint  = { fg = "diagnostic.hint" },
    DiagnosticVirtualTextOk    = { fg = "diagnostic.ok" },

    -- LSP 语义
    LspReferenceText = { bg = "#b4b4b4" },
    LspReferenceRead = { bg = "#b4b4b4" },
    LspReferenceWrite = { bg = "#ff6464" },
    LspCodeLens = { fg = "fg2" },
    LspInlayHint = { fg = "fg2", style = "italic" },

    -- Git 标志
    GitSignsAdd    = { fg = "git.add" },
    GitSignsChange = { fg = "git.change" },
    GitSignsDelete = { fg = "git.delete" },

    -- 链接
    Underlined    = { fg = "link_blue", style = "underline" },
    url           = { fg = "link_blue", style = "underline" },

    -- 变量出现
    LspDiagnosticsDefaultError = { fg = "diagnostic.error" },
    LspDiagnosticsDefaultWarning = { fg = "diagnostic.warn" },
    LspDiagnosticsDefaultInformation = { fg = "diagnostic.info" },
    LspDiagnosticsDefaultHint = { fg = "diagnostic.hint" },
  },

  classic = {
    -- 特定的 Classic 风格覆盖
    Comment       = { fg = "comment", style = "NONE" },
    String        = { fg = "syntax.string", style = "NONE" },
    Number        = { fg = "syntax.number", style = "NONE" },
    Boolean       = { fg = "syntax.boolean", style = "NONE" },
    Float         = { fg = "syntax.float", style = "NONE" },
    Identifier    = { fg = "syntax.variable", style = "NONE" },
    Function      = { fg = "syntax.func", style = "NONE" },
    Constant      = { fg = "syntax.constant", style = "NONE" },
    Statement     = { fg = "syntax.keyword", style = "NONE" },
    Conditional   = { fg = "syntax.conditional", style = "NONE" },
    Repeat        = { fg = "syntax.keyword", style = "NONE" },
    Label         = { fg = "syntax.label", style = "NONE" },
    Operator      = { fg = "syntax.operator", style = "NONE" },
    Keyword       = { fg = "syntax.keyword", style = "NONE" },
    Exception     = { fg = "syntax.keyword", style = "NONE" },
    PreProc       = { fg = "syntax.preproc", style = "NONE" },
    Include       = { fg = "syntax.include", style = "NONE" },
    Define        = { fg = "syntax.define", style = "NONE" },
    Macro         = { fg = "syntax.macro", style = "NONE" },
    PreCondit     = { fg = "syntax.preproc", style = "NONE" },
    Type          = { fg = "syntax.type", style = "NONE" },
    StorageClass  = { fg = "syntax.keyword", style = "NONE" },
    Structure     = { fg = "syntax.type", style = "NONE" },
    Typedef       = { fg = "syntax.type", style = "NONE" },
    Special       = { fg = "dark_blue", style = "NONE" },
    SpecialChar   = { fg = "dark_blue", style = "NONE" },
    Tag           = { fg = "dark_magenta", style = "NONE" },
    Delimiter     = { fg = "fg1", style = "NONE" },
    SpecialComment= { fg = "comment", style = "NONE" },
    Debug         = { fg = "red", style = "NONE" },
  },
}

-- 返回配置
return nightfox_classic
