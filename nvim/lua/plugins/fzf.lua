local actions = require "fzf-lua.actions"

require'fzf-lua'.setup {
  winopts = {
    -- split = "belowright 10new", -- open in a split instead?
    height = 0.30, -- window height
    width = 1.0, -- window width
    row = 0.9999, -- window row position (0=top, 1=bottom)
    col = 0.80, -- window col position (0=left, 1=right)
    -- win_border = 'window border', -- window border? or borderchars?
    border = 'double',
    fullscreen = false, -- start fullscreen?
    window_on_create = function()
      vim.cmd("set winhl=Normal:Normal") -- popup bg to match normal windows
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-c>",
                                  {nowait = true, silent = true})
    end,

    hl = {
      normal = 'Normal', -- window normal color (fg+bg)
      border = 'FloatBorder', -- 'Normal', -- border color (try 'FloatBorder')
      -- Only valid with the builtin previewer:
      cursor = 'Cursor', -- cursor highlight (grep/LSP matches)
      cursorline = 'CursorLine' -- cursor line
      -- title       = 'Normal',        -- preview border title (file/buffer)
      -- scrollbar_f = 'empty', -- scrollbar "full" section highlight
      -- scrollbar_e = 'empty' -- scrollbar "empty" section highlight
    },
    preview = {
      -- default     = 'bat',           -- override the default previewer?
      -- default uses the 'builtin' previewer
      border = 'border', -- border|noborder, applies only to
      -- native fzf previewers (bat/cat/git/etc)
      wrap = 'nowrap', -- wrap|nowrap
      hidden = 'nohidden', -- hidden|nohidden
      vertical = 'down:45%', -- up|down:size
      horizontal = 'right:60%', -- right|left:size
      layout = 'flex', -- horizontal|vertical|flex
      flip_columns = 120, -- #cols to switch to horizontal on flex
      -- Only valid with the builtin previewer:
      title = true, -- preview border title (file/buf)?
      scrollbar = 'float', -- `false` or string:'float|border'
      -- float:  in-window floating border 
      -- border: in-border chars (see below)
      scrolloff = '-2', -- float scrollbar offset from right
      -- applies only when scrollbar = 'float'
      scrollchars = {'|', ''} -- scrollbar chars ({ <full>, <empty> }
      -- applies only when scrollbar = 'border'
    }
  },
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F2>"] = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<C-o>"] = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"] = "toggle-preview-ccw",
      ["<F6>"] = "toggle-preview-cw",
      ["<S-down>"] = "preview-page-down",
      ["<S-up>"] = "preview-page-up",
      ["<S-left>"] = "preview-page-reset"
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-u"] = "unix-line-discard",
      ["ctrl-f"] = "forward-char",
      ["ctrl-b"] = "backward-char",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["ctrl-x"] = "delete-char",
      ["alt-a"] = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["shift-down"] = "preview-page-down",
      ["shift-up"] = "preview-page-up"
    }
  },
  fzf_opts = {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    ['--ansi'] = '',
    ['--prompt'] = ' =',
    ['--info'] = 'inline',
    ['--height'] = '100%',
    ['--layout'] = 'reverse',
    ['--border'] = 'none',
    ['--color'] = '--color=bg+:red,border:-1'
  },
  -- fzf_args = '-e --no-sort', -- adv: fzf extra args, empty unless adv

  preview_border = 'border', -- border|noborder
  preview_wrap = 'nowrap', -- wrap|nowrap
  preview_opts = 'hidden', -- hidden|nohidden
  preview_vertical = 'up:50%', -- up|down:size
  preview_horizontal = 'right:50%', -- right|left:size
  preview_layout = 'horizontal', -- horizontal|vertical|flex
  flip_columns = 20, -- #cols to switch to horizontal on flex
  default_previewer = 'builtin', -- override the default previewer?

  previewers = {
    git_diff = {cmd = "git diff", args = "--color"},
    builtin = {
      title = true, -- preview title?
      scrollbar = true, -- scrollbar?
      scrollchar = '█', -- scrollbar character
      syntax = true, -- preview syntax highlight?
      syntax_limit_l = 3000, -- syntax limit (lines), 0=nolimit
      syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
      expand = false, -- preview max size?
      hl_cursor = 'Cursor', -- cursor highlight
      hl_cursorline = 'CursorLine', -- cursor line highlight
      hl_range = 'IncSearch' -- ranger highlight (not yet in use)
    }
  },
  -- provider setup
  files = {
    prompt = 'Files❯ ',
    cmd = 'fd', -- "find . -type f -printf '%P\n'",
    fd_opts = [[--color never --type f --follow -t f]] ..
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
  my_files = {
    -- previewer = false, -- uncomment to override previewer
    prompt = 'Files❯ ',
    cmd = 'fd', -- "find . -type f -printf '%P\n'",
    fd_opts = [[--color never --type f --follow  -t f]] ..
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
    -- previewer = false, -- uncomment to override previewer
    prompt = 'Rg❯ ',
    input_prompt = 'Grep For❯ ',
    cmd = "rg --vimgrep",
    rg_opts = "--hidden --no-column --line-number --no-heading " ..
        "--color=always --smart-case -g '!{.git,.cache,node_modules,zlib-1.2.11}/*'",
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
  oldfiles = {
    prompt = 'History❯ ',
    cwd_only = false
    -- , previewer = false
  },
  buffers = {
    prompt = 'Buffers ❯ ',
    file_icons = true, -- show file icons?
    sort_lastused = true, -- sort buffers() by last used
    actions = {
      ["default"] = actions.buf_edit,
      ["ctrl-s"] = actions.buf_split,
      ["ctrl-v"] = actions.buf_vsplit,
      ["ctrl-t"] = actions.buf_tabedit,
      ["ctrl-x"] = actions.buf_del
    },
    ignore_current_buffer = false
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
    prompt = '❯ ',
    -- cwd = vim.call('asyncrun#get_root', '%'),
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
