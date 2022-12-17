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

