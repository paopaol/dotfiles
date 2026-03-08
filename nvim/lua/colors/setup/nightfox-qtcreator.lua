-- Nightfox Classic Theme Configuration
-- 基于 Qt Creator Default Classic 主题配色
-- 使用方法：在 Neovim 配置中使用 require("nightfox-classic")

local colors = {}

-- 基于 Qt Creator Default Classic 的调色板
colors.palettes = {
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
		bg0          = "#ffffff", -- 背景色（深色版本）
		bg1          = "#ffffff", -- 主要背景
		bg2          = "#f5fafd", -- 搜索范围背景
		bg3          = "#efebe7", -- 行号背景
		bg4          = "#efefef", -- 禁用代码背景

		fg0          = "#000000", -- 深色前景
		fg1          = "#000000", -- 主要前景
		fg2          = "#9f9d9a", -- 行号前景
		fg3          = "#808080", -- 当前行号前景

		-- 选择和搜索颜色
		sel0         = "#c1ddee", -- 当前行背景
		sel1         = "#308cc6", -- 选择背景

		-- 注释颜色
		comment      = "#008000",

		-- 自定义颜色
		dark_blue    = "#000080", -- 数字、预处理器
		dark_red     = "#800000", -- 字段、标签、绑定
		dark_magenta = "#800080", -- 类型、静态
		dark_yellow  = "#808000", -- 关键字、属性、基本类型
		olive_green  = "#008000", -- 字符串、注释
		link_blue    = "#0000ff", -- 链接
		search_bg    = "#ffef0b", -- 搜索结果背景
		js_scope     = "#2985c7", -- JS 作用域变量
		js_import    = "#0055af", -- JS 导入变量
	},
}

-- 规格定义（将调色板映射到逻辑组）
colors.specs = {
	all = {
		syntax = {
			keyword     = colors.palettes.classic.dark_yellow, -- 关键字
			conditional = colors.palettes.classic.dark_yellow, -- 条件语句
			constant    = colors.palettes.classic.dark_blue, -- 常量
			number      = colors.palettes.classic.dark_blue, -- 数字
			float       = colors.palettes.classic.dark_blue, -- 浮点数
			boolean     = colors.palettes.classic.dark_blue, -- 布尔值
			string      = colors.palettes.classic.olive_green, -- 字符串
			character   = colors.palettes.classic.olive_green, -- 字符
			type        = colors.palettes.classic.dark_magenta, -- 类型
			func        = "#2985C7",       -- 函数
			variable    = colors.palettes.classic.fg1, -- 变量
			operator    = colors.palettes.classic.fg1, -- 操作符
			preproc     = colors.palettes.classic.dark_blue, -- 预处理器
			include     = colors.palettes.classic.dark_blue, -- 包含
			define      = colors.palettes.classic.dark_blue, -- 定义
			macro       = colors.palettes.classic.dark_blue, -- 宏
			parameter   = colors.palettes.classic.fg1, -- 参数
			field       = colors.palettes.classic.dark_red, -- 字段
			property    = colors.palettes.classic.dark_red, -- 属性
			enum        = colors.palettes.classic.dark_magenta, -- 枚举
			enumConst   = colors.palettes.classic.dark_blue, -- 枚举常量
			label       = colors.palettes.classic.dark_red, -- 标签
			todo        = colors.palettes.classic.orange, -- TODO
		},
		git = {
			add      = "#DFFFDF", -- 添加行
			change   = "#ff8000", -- 修改行
			delete   = "#FEE4E4", -- 删除行
			conflict = "#FEE4E4", -- 冲突
		},
		diff = {
			add       = "#DFFFDF", -- 添加
			change    = "#308cc6", -- 修改
			delete    = "#FEE4E4", -- 删除
			text      = "#000000", -- 文本
			add_bg    = "#dfffdf", -- 添加背景
			change_bg = "#c1ddee", -- 修改背景
			delete_bg = "#ffdfdf", -- 删除背景
		},
		diagnostic = {
			error = "#ff0000", -- 错误
			warn  = "#ffbe00", -- 警告
			info  = "#262088", -- 信息
			hint  = "#308cc6", -- 提示
			ok    = "#008000", -- OK
		},
	},

	classic = {
		syntax = {
			keyword = colors.palettes.classic.dark_yellow,
			string  = colors.palettes.classic.olive_green,
		},
	},
}

-- 高亮组定义
colors.groups = {
	all = {
		-- 编辑器基础样式
		Normal                                                           = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.bg1 },
		NormalFloat                                                      = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.bg1 },
		NormalNC                                                         = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.bg1 },

		-- 当前行和行号
		CursorLine                                                       = { bg = colors.palettes.classic.sel0 },
		CursorLineNr                                                     = { fg = colors.palettes.classic.fg3, bg = colors.palettes.classic.sel0, style = "bold" },
		LineNr                                                           = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },
		SignColumn                                                       = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },

		-- 选择和搜索
		Visual                                                           = { fg = "#ffffff", bg = colors.palettes.classic.sel1 },
		VisualNOS                                                        = { fg = "#ffffff", bg = colors.palettes.classic.sel1 },
		Search                                                           = { bg = colors.palettes.classic.search_bg },
		IncSearch                                                        = { bg = colors.palettes.classic.search_bg },

		-- 括号匹配
		MatchParen                                                       = { fg = colors.palettes.all.red, bg = "#b4eeb4" },

		-- 自动补全
		Pmenu                                                            = { fg = colors.palettes.classic.dark_blue, bg = "#c0c0ff" },
		PmenuSel                                                         = { fg = "#ffffff", bg = colors.palettes.classic.sel1 },
		PmenuSbar                                                        = { bg = "#c0c0c0" },
		PmenuThumb                                                       = { bg = "#808080" },

		-- 状态栏
		StatusLine                                                       = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.sel0 },
		StatusLineNC                                                     = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },

		-- 标签页
		TabLine                                                          = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },
		TabLineFill                                                      = { bg = colors.palettes.classic.bg3 },
		TabLineSel                                                       = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.sel0, style = "bold" },

		-- 垂直分割线
		VertSplit                                                        = { fg = "#c0c0c0", bg = colors.palettes.classic.bg1 },

		-- 光标
		Cursor                                                           = { fg = colors.palettes.classic.bg1, bg = colors.palettes.classic.fg1 },
		lCursor                                                          = { fg = colors.palettes.classic.bg1, bg = colors.palettes.classic.fg1 },
		CursorIM                                                         = { fg = colors.palettes.classic.bg1, bg = colors.palettes.classic.fg1 },

		-- 折叠
		Folded                                                           = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },
		FoldColumn                                                       = { fg = colors.palettes.classic.fg2, bg = colors.palettes.classic.bg3 },

		-- 特殊字符
		Whitespace                                                       = { fg = "#c0c0c0" },
		NonText                                                          = { fg = "#c0c0c0" },
		SpecialKey                                                       = { fg = "#c0c0c0" },

		-- 消息
		MsgArea                                                          = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.bg1 },
		MsgSeparator                                                     = { fg = colors.palettes.classic.fg1, bg = colors.palettes.classic.bg1 },
		MoreMsg                                                          = { fg = colors.palettes.classic.dark_blue, style = "bold" },
		ModeMsg                                                          = { fg = colors.palettes.classic.fg1 },
		Question                                                         = { fg = colors.palettes.classic.olive_green, style = "bold" },
		WarningMsg                                                       = { fg = colors.palettes.all.orange, style = "bold" },
		ErrorMsg                                                         = { fg = colors.palettes.all.red, style = "bold" },

		-- 标题
		Title                                                            = { fg = colors.palettes.classic.dark_magenta, style = "bold" },

		-- 差异显示
		DiffAdd                                                          = { fg = colors.specs.all.git.add, bg = colors.specs.all.diff.add_bg },
		DiffChange                                                       = { fg = colors.specs.all.git.change, bg = colors.specs.all.diff.change_bg },
		DiffDelete                                                       = { fg = colors.specs.all.git.delete, bg = colors.specs.all.diff.delete_bg },
		DiffText                                                         = { fg = colors.specs.all.diff.text, bg = "#ffff00" },
		DiffAdded                                                        = { fg = colors.specs.all.git.add },
		DiffRemoved                                                      = { fg = colors.specs.all.git.delete },
		DiffFile                                                         = { fg = colors.palettes.classic.dark_blue },
		DiffIndexLine                                                    = { fg = colors.palettes.classic.link_blue },

		-- 拼写检查
		SpellBad                                                         = { fg = colors.palettes.red, style = "underline" },
		SpellCap                                                         = { fg = colors.palettes.orange, style = "underline" },
		SpellLocal                                                       = { fg = colors.palettes.cyan, style = "underline" },
		SpellRare                                                        = { fg = colors.palettes.classic.dark_magenta, style = "underline" },

		-- 诊断
		DiagnosticError                                                  = { fg = colors.specs.all.diagnostic.error },
		DiagnosticWarn                                                   = { fg = colors.specs.all.diagnostic.warn },
		DiagnosticInfo                                                   = { fg = colors.specs.all.diagnostic.info },
		DiagnosticHint                                                   = { fg = colors.specs.all.diagnostic.hint },
		DiagnosticOk                                                     = { fg = colors.specs.all.diagnostic.ok },
		DiagnosticUnderlineError                                         = { fg = colors.specs.all.diagnostic.error, style = "underline" },
		DiagnosticUnderlineWarn                                          = { fg = colors.specs.all.diagnostic.warn, style = "underline" },
		DiagnosticUnderlineInfo                                          = { fg = colors.specs.all.diagnostic.info, style = "underline" },
		DiagnosticUnderlineHint                                          = { fg = colors.specs.all.diagnostic.hint, style = "underline" },
		DiagnosticUnderlineOk                                            = { fg = colors.specs.all.diagnostic.ok, style = "underline" },
		DiagnosticVirtualTextError                                       = { fg = colors.specs.all.diagnostic.error },
		DiagnosticVirtualTextWarn                                        = { fg = colors.specs.all.diagnostic.warn },
		DiagnosticVirtualTextInfo                                        = { fg = colors.specs.all.diagnostic.info },
		DiagnosticVirtualTextHint                                        = { fg = colors.specs.all.diagnostic.hint },
		DiagnosticVirtualTextOk                                          = { fg = colors.specs.all.diagnostic.ok },

		-- LSP 语义
		LspReferenceText                                                 = { bg = "#b4b4b4" },
		LspReferenceRead                                                 = { bg = "#b4b4b4" },
		LspReferenceWrite                                                = { bg = "#ff6464" },
		LspCodeLens                                                      = { fg = colors.palettes.classic.fg2 },
		LspInlayHint                                                     = { fg = colors.palettes.classic.fg2, style = "italic" },

		-- Git 标志
		GitSignsAdd                                                      = { fg = colors.specs.all.git.add },
		GitSignsChange                                                   = { fg = colors.specs.all.git.change },
		GitSignsDelete                                                   = { fg = colors.specs.all.git.delete },

		-- 链接
		Underlined                                                       = { fg = colors.palettes.classic.link_blue, style = "underline" },
		url                                                              = { fg = colors.palettes.classic.link_blue, style = "underline" },

		-- 变量出现
		LspDiagnosticsDefaultError                                       = { fg = colors.specs.all.diagnostic.error },
		LspDiagnosticsDefaultWarning                                     = { fg = colors.specs.all.diagnostic.warn },
		LspDiagnosticsDefaultInformation                                 = { fg = colors.specs.all.diagnostic.info },
		LspDiagnosticsDefaultHint                                        = { fg = colors.specs.all.diagnostic.hint },

    ["Type"]                              = { link = "@type" },
		["Structure"]                                                    = { link = "@type" },
		["@lsp"]                                                         = { fg = colors.palettes.classic.dark_blue },
		["@module"]                                                      = { link = "@type" }, -- 兜底 treesitter 映射
		["@lsp.mod.declaration.cpp"]                                     = { fg = colors.specs.all.syntax.type },
		["@lsp.mod.globalScope.cpp"]                                     = { fg = colors.specs.all.syntax.type },
		["@lsp.mod.classScope.cpp"]                                      = { fg = colors.palettes.classic.fg1 },
		["@lsp.mod.static.cpp"]                                          = { fg = colors.palettes.classic.dark_magenta, style = "italic" }, -- 静态成员
		["@lsp.mod.functionScope.cpp"]                                   = { link = "@variable" },
		["@lsp.mod.usedAsMutablePointer.cpp"]                            = { link = "@variable" },
		["@lsp.mod.readonly.cpp"]                                        = { link = "@constant" }, -- 常量
		["@lsp.mod.reference.cpp"]                                       = { link = "@variable" }, -- 引用
		["@lsp.mod.defaultLibrary.cpp"]                                  = { link = "@function.builtin" }, -- 标准库函数
    ["@lsp.mod.fileScope.cpp"]            = { fg = colors.specs.all.syntax.type },
		["@lsp.type.property.cpp"]                                       = { link = "@property" },
		["@lsp.type.variable.cpp"]                                       = { link = "@variable" },
		["@lsp.type.enumMember.cpp"]                                     = { link = "@constant" },
		["@lsp.type.macro.cpp"]                                          = { link = "@function.macro" },
		["@lsp.type.namespace.cpp"]                                      = { link = "@type" },       -- 对应 dark_magenta
		["@lsp.type.class.cpp"]                                          = { link = "@type" },
		["@lsp.type.struct.cpp"]                                         = { link = "@type" },
		["@lsp.type.method.cpp"]                                         = { link = "@function" }, -- 黑色 (fg1)
    ["@lsp.type.enum.cpp"]                = { link = "@type" },
		["@lsp.type.type.cpp"]                = { link = "@type" },
		["@lsp.typemod.function.classScope.cpp"]                         = { link = "@function" },
		["@lsp.typemod.property.classScope.cpp"]                         = { fg = colors.specs.all.syntax.field }, -- 对应 Qt Creator 的字段/成员颜色
		["@lsp.typemod.method.classScope.cpp"]                           = { link = "@function" },
		["@lsp.typemod.variable.functionScope.cpp"]                      = { link = "@variable" },
		["@lsp.typemod.variable.usedAsMutablePointer.cpp"]               = { link = "@variable" },
		["@lsp.typemod.variable.functionScope.usedAsMutablePointer.cpp"] = { link = "@variable" },
		["@lsp.typemod.variable.global.cpp"]                             = { fg = colors.palettes.classic.dark_red, style = "bold" },
		["@lsp.typemod.variable.local.cpp"]                              = { link = "@variable" },
		["@lsp.typemod.namespace.declaration.cpp"]                       = { link = "@type" },
		["@lsp.typemod.namespace.globalScope.cpp"]                       = { link = "@type" },
		["@lsp.typemod.namespace"]                                       = { link = "@type" },
    ["@lsp.typemod.type.fileScope.cpp"]   = { link = "@type" },
    ["@lsp.typemod.property.usedAsMutablePointer.cpp"] = { link = "@property" },
    ["@lsp.typemod.property.classScope.usedAsMutablePointer.cpp"] = { link = "@property" },
    ["@lsp.typemod.property.readonly.cpp"]     = { link = "@property" },
    ["@lsp.typemod.type.declaration.cpp"] = { link = "@type" },
    ["@lsp.typemod.type.globalScope.cpp"] = { link = "@type" },
		["@lsp.typemod.class.globalScope.cpp"]                           = { link = "@type" },
		["@lsp.typemod.struct.globalScope.cpp"]                          = { link = "@type" },
		["@lsp.typemod.class.declaration.cpp"]                           = { link = "@type" },
		["@lsp.typemod.struct.declaration.cpp"]                          = { link = "@type" },
		["@lsp.typemod.method.defaultLibrary.cpp"]                       = { link = "@function.builtin" },
		["@lsp.typemod.method.static.cpp"]                               = { fg = colors.palettes.classic.dark_magenta, style = "italic" },
    ["@lsp.typemod.enum.declaration.cpp"] = { link = "@type" },
    ["@lsp.typemod.enum.globalScope.cpp"]  = { link = "@type" },
    ["@lsp.typemod.enumMember.globalScope.cpp"] = { fg = colors.palettes.classic.dark_blue },

		-- Treesitter 映射 (核心：将 TS 组链接到你定义好的规格上)
		["@variable"]                                                    = { fg = colors.specs.all.syntax.variable },
		["@variable.builtin"]                                            = { fg = colors.specs.all.syntax.keyword, style = "bold" },
		["@function"]                                                    = { fg = colors.specs.all.syntax.func },
		["@function.builtin"]                                            = { fg = colors.specs.all.syntax.func },
		["@function.macro"]                                              = { fg = colors.specs.all.syntax.macro },

		["@keyword"]                                                     = { fg = colors.specs.all.syntax.keyword },
		["@keyword.function"]                                            = { fg = colors.specs.all.syntax.keyword },
		["@keyword.operator"]                                            = { fg = colors.specs.all.syntax.keyword },
		["@keyword.return"]                                              = { fg = colors.specs.all.syntax.keyword },

		["@string"]                                                      = { fg = colors.specs.all.syntax.string },
		["@number"]                                                      = { fg = colors.specs.all.syntax.number },
		["@boolean"]                                                     = { fg = colors.specs.all.syntax.boolean },
		["@constant"]                                                    = { fg = colors.specs.all.syntax.constant },
		["@type"]                                                        = { fg = colors.specs.all.syntax.type },
		["@type.builtin"]                                                = { fg = colors.specs.all.syntax.type },

		["@constructor"]                                                 = { fg = colors.specs.all.syntax.type },
		["@constructor.cpp"]                                             = { link = "@type" }, -- Qt Creator 中构造函数通常跟类名颜色一致 (紫色)
		["@parameter"]                                                   = { fg = colors.specs.all.syntax.parameter },
		["@field"]                                                       = { fg = colors.specs.all.syntax.field },
		["@property"]                                                    = { fg = colors.specs.all.syntax.property },
		["@label"]                                                       = { fg = colors.specs.all.syntax.label },
		["@comment"]                                                     = { fg = colors.palettes.classic.comment },
		["@punctuation.bracket"]                                         = { fg = colors.palettes.classic.fg1 }, -- 括号
		["@operator"]                                                    = { fg = colors.palettes.classic.fg1 }, -- 运算符

		-- C++ 专有 (Treesitter 更精细的分类)
		["@namespace"]                                                   = { fg = colors.specs.all.syntax.type },
		["@preproc"]                                                     = { fg = colors.specs.all.syntax.preproc },
		["@include"]                                                     = { fg = colors.specs.all.syntax.include },
	},

	classic = {
		-- 特定的 Classic 风格覆盖
		Comment        = { fg = colors.palettes.classic.comment, style = "NONE" },
		String         = { fg = colors.specs.all.syntax.string, style = "NONE" },
		Number         = { fg = colors.specs.all.syntax.number, style = "NONE" },
		Boolean        = { fg = colors.specs.all.syntax.boolean, style = "NONE" },
		Float          = { fg = colors.specs.all.syntax.float, style = "NONE" },
		Identifier     = { fg = colors.specs.all.syntax.variable, style = "NONE" },
		Function       = { fg = colors.specs.all.syntax.func, style = "NONE" },
		Constant       = { fg = colors.specs.all.syntax.constant, style = "NONE" },
		Statement      = { fg = colors.specs.all.syntax.keyword, style = "NONE" },
		Conditional    = { fg = colors.specs.all.syntax.conditional, style = "NONE" },
		Repeat         = { fg = colors.specs.all.syntax.keyword, style = "NONE" },
		Label          = { fg = colors.specs.all.syntax.label, style = "NONE" },
		Operator       = { fg = colors.specs.all.syntax.operator, style = "NONE" },
		Keyword        = { fg = colors.specs.all.syntax.keyword, style = "NONE" },
		Exception      = { fg = colors.specs.all.syntax.keyword, style = "NONE" },
		PreProc        = { fg = colors.specs.all.syntax.preproc, style = "NONE" },
		Include        = { fg = colors.specs.all.syntax.include, style = "NONE" },
		Define         = { fg = colors.specs.all.syntax.define, style = "NONE" },
		Macro          = { fg = colors.specs.all.syntax.macro, style = "NONE" },
		PreCondit      = { fg = colors.specs.all.syntax.preproc, style = "NONE" },
		Type           = { fg = colors.specs.all.syntax.type, style = "NONE" },
		StorageClass   = { fg = colors.specs.all.syntax.keyword, style = "NONE" },
		Structure      = { fg = colors.specs.all.syntax.type, style = "NONE" },
		Typedef        = { fg = colors.specs.all.syntax.type, style = "NONE" },
		Special        = { fg = colors.palettes.classic.dark_blue, style = "NONE" },
		SpecialChar    = { fg = colors.palettes.classic.dark_blue, style = "NONE" },
		Tag            = { fg = colors.palettes.classic.dark_magenta, style = "NONE" },
		Delimiter      = { fg = colors.palettes.classic.fg1, style = "NONE" },
		SpecialComment = { fg = colors.palettes.classic.comment, style = "NONE" },
		Debug          = { fg = colors.palettes.all.red, style = "NONE" },
	},
}

-- 返回配置
return colors
