local actions = require "fzf-lua.actions"

require'fzf-lua'.setup {
  winopts = {
    -- split         = "new",           -- open in a split instead?
    win_height = 0.25, -- window height
    win_width = 1.0, -- window width
    win_row = 1, -- window row position (0=top, 1=bottom)
    win_col = 0.80, -- window col position (0=left, 1=right)
    -- win_border = false, -- window border? or borderchars?
    window_on_create = function()
      vim.cmd("set winhl=Normal:Normal") -- popup bg to match normal windows
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-c>",
                                  {nowait = true, silent = true})
    end,
    win_border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}
    -- hl_xxx = function() -- nvim window options override
    --   vim.cmd("set winhl=Normal:Normal") -- popup bg match normal windows
    -- end
  },
  -- fzf_bin             = 'sk',        -- use skim instead of fzf?
  fzf_layout = 'reverse', -- fzf '--layout='reverse
  fzf_args = '-e --no-sort -1', -- adv: fzf extra args, empty unless adv
  fzf_binds = { -- fzf '--bind=' options
    'f2:toggle-preview', 'f3:toggle-preview-wrap', 'ctrl-d:preview-down',
    'ctrl-u:preview-up', 'ctrl-f:page-down', 'ctrl-b:page-up',
    'ctrl-a:toggle-all', 'ctrl-l:clear-query'
  },

  preview_border = 'border', -- border|noborder
  preview_wrap = 'nowrap', -- wrap|nowrap
  preview_opts = 'hidden', -- hidden|nohidden
  preview_vertical = 'up:50%', -- up|down:size
  preview_horizontal = 'right:50%', -- right|left:size
  preview_layout = 'vertical', -- horizontal|vertical|flex
  flip_columns = 20, -- #cols to switch to horizontal on flex
  default_previewer = 'builtin', -- override the default previewer?
  -- by default auto-detect bat|cat
  previewers = {
    -- cmd = {
    --   -- custom previewer, will execute:
    --   -- `<cmd> <args> <filename>`
    --   cmd = "echo",
    --   args = ""
    -- },
    -- cat = {cmd = "cat", args = "--number"},
    -- bat = {
    --   cmd = "bat",
    --   args = "--style=numbers,changes --color always",
    --   theme = 'Monokai Extended Light', -- bat preview theme (bat --list-themes)
    --   config = nil -- nil uses $BAT_CONFIG_PATH
    -- },
    -- head = {cmd = "head", args = nil},
    git_diff = {cmd = "git diff", args = "--color"},
    builtin = {
      title = true, -- preview title?
      scrollbar = true, -- scrollbar?
      scrollchar = '█', -- scrollbar character
      wrap = false, -- wrap lines?
      syntax = true, -- preview syntax highlight?
      syntax_limit_l = 3000, -- syntax limit (lines), 0=nolimit
      syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
      expand = false, -- preview max size?
      hl_cursor = 'Cursor', -- cursor highlight
      hl_cursorline = 'CursorLine', -- cursor line highlight
      hl_range = 'IncSearch', -- ranger highlight (not yet in use)
      keymap = {
        toggle_full = '<F2>', -- toggle full screen
        toggle_wrap = '<F3>', -- toggle line wrap
        toggle_hide = '<F4>', -- toggle on/off (not yet in use)
        page_up = '<S-up>', -- preview scroll up
        page_down = '<S-down>', -- preview scroll down
        page_reset = '<S-left>' -- reset scroll to orig pos
      }
    }
  },
  -- provider setup
  files = {
    previewer = false, -- uncomment to override previewer
    prompt = 'Files❯ ',
    cmd = 'fd', -- "find . -type f -printf '%P\n'",
    fd_opts = [[--color never --type f --follow ]] ..
        [[--exclude .git --exclude node_modules --exclude '*.pyc' --exclude moc_* --exclude *.o]],
    git_icons = true, -- show git icons?
    file_icons = true, -- show file icons?
    color_icons = true, -- colorize file|git icons
    actions = {
      ["default"] = actions.file_edit,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-y"] = function(selected) print(selected[2]) end
    }
  },
  git = {
    files = {
      prompt = 'GitFiles❯ ',
      cmd = 'git ls-files --exclude-standard',
      git_icons = true, -- show git icons?
      file_icons = true, -- show file icons?
      color_icons = true -- colorize file|git icons
    },
    status = {
      prompt = 'GitStatus❯ ',
      cmd = "git status -s",
      previewer = "git_diff",
      file_icons = true,
      git_icons = true,
      color_icons = true
    },
    commits = {
      prompt = 'Commits❯ ',
      cmd = "git log --pretty=oneline --abbrev-commit --color",
      preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {["default"] = nil}
    },
    bcommits = {
      prompt = 'BCommits❯ ',
      cmd = "git log --pretty=oneline --abbrev-commit --color --",
      preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {["default"] = nil}
    },
    branches = {
      prompt = 'Branches❯ ',
      cmd = "git branch --all --color",
      preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {["default"] = actions.git_switch}
    },
    icons = {
      ["M"] = {icon = "M", color = "yellow"},
      ["D"] = {icon = "D", color = "red"},
      ["A"] = {icon = "A", color = "green"},
      ["?"] = {icon = "?", color = "magenta"}
      -- ["M"]          = { icon = "★", color = "red" },
      -- ["D"]          = { icon = "✗", color = "red" },
      -- ["A"]          = { icon = "+", color = "green" },
    }
  },
  grep = {
    previewer = false, -- uncomment to override previewer
    prompt = 'Rg❯ ',
    input_prompt = 'Grep For❯ ',
    cmd = "rg --vimgrep",
    rg_opts = "--hidden --no-column --line-number --no-heading " ..
        "--color=always --smart-case -g '!{.git,.cache,node_modules,}/*'",
    git_icons = true, -- show git icons?
    file_icons = true, -- show file icons?
    color_icons = true, -- colorize file|git icons
    actions = {
      ["default"] = actions.file_edit,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-y"] = function(selected) print(selected[2]) end
    }
  },
  oldfiles = {prompt = 'History❯ ', cwd_only = false, previewer = false},
  buffers = {
    prompt = 'Buffers ❯ ',
    previewer = false, -- uncomment to override previewer
    file_icons = true, -- show file icons?
    sort_lastused = true, -- sort buffers() by last used
    actions = {
      ["default"] = actions.buf_edit,
      ["ctrl-s"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit,
      ["ctrl-t"] = actions.buf_tabedit,
      ["ctrl-x"] = actions.buf_del
    }
  },
  colorschemes = {
    prompt = 'Colorschemes❯ ',
    live_preview = true, -- apply the colorscheme on preview?
    actions = {
      ["default"] = actions.colorscheme,
      ["ctrl-y"] = function(selected) print(selected[2]) end
    },
    winopts = {
      win_height = 0.55,
      win_width = 0.30,
      hl_xxx = function() vim.cmd("set winhl=Normal:Normal") end
    },
    post_reset_cb = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end
  },
  blines = {
    previewer = false,
    prompt = 'BLines❯ ',
    actions = {
      ["default"] = actions.buf_edit,
      ["ctrl-s"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit,
      ["ctrl-t"] = actions.buf_tabedit
    }
  },
  quickfix = {
    -- cwd               = vim.loop.cwd(),
    file_icons = true,
    git_icons = true
  },
  lsp = {
    previewer = false,
    prompt = '❯ ',
    -- cwd               = vim.loop.cwd(),
    cwd_only = false, -- show workspace diagnostics only for the files in cwd
    file_icons = true,
    git_icons = false,
    lsp_icons = true,
    severity = "hint",
    icons = {
      ["Error"] = {icon = "", color = "red"}, -- error
      ["Warning"] = {icon = "", color = "yellow"}, -- warning
      ["Information"] = {icon = "", color = "blue"}, -- info
      ["Hint"] = {icon = "", color = "magenta"} -- hint
    },
    actions = {
      ["default"] = actions.file_edit,
      ["ctrl-s"] = actions.file_split,
      ["ctrl-v"] = actions.file_vsplit,
      ["ctrl-t"] = actions.file_tabedit,
      ["ctrl-q"] = actions.file_sel_to_qf,
      ["ctrl-y"] = function(selected) print(selected[2]) end
    }
  },
  -- placeholders for additional user customizations
  loclist = {},
  helptags = {},
  -- manpages = {},
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  file_icon_colors = {["lua"] = "blue"}

}
