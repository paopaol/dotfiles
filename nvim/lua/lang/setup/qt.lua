local utils = require('base.utils')
local cmd = require('telescope').load_extension('command')

local designer_open_file = function()
  cmd.command({
    cmd = { 'fd', '-e', 'ui' },
    selected_action = function(selection)
      local ui_file = selection.value
      vim.cmd(string.format('AsyncRun -silent designer %s/%s', utils.rootdir(), ui_file))
    end
  })
end
vim.api.nvim_create_user_command("DesignerOpen", designer_open_file, {})
