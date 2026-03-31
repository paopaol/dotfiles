local utils = require("base.utils")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

require("base.utils").make_keymap({ "xml", "html" }, "xml-group", {
  { "<tab>", command("normal! za"), desc = "expand" },
})

require("base.utils").make_keymap(
  { "xml", "html", "json", "css", "javascript", "yaml", "vue", "typescript", "toml" },
  "web-group",
  {
    { "<localleader>,", utils.format_buffer, desc = "formatting", mode = "nv" },
  }
)

require("nvim-ts-autotag").setup({ filetypes = { "html", "xml" } })

vim.keymap.set("v", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format selection" })
