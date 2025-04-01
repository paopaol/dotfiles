local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end
require("base.utils").make_keymap({ "fugitive", "git" }, "git-group", {
  { "<localleader><C-t>", command("normal O"),  desc = "open with tab", },
  { "<localleader>gv",    command("normal gO"), desc = "open with vertical", },
  { "<localleader>gs",    command("normal o"),  desc = "open with split", },
})
