require("neorg").setup({
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = {}, -- Allows for use of icons
    ['core.norg.completion'] = {
      config = { engine = 'nvim-cmp' }
    },
    ['core.presenter'] = {
      config = {
	zen_mode = 'zen-mode',
      },
    },
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
    config = { workspaces = { my_workspace = "~/workspace/jz/note" } },
  },
},
})

require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})
