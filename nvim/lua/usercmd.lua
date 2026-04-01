vim.api.nvim_create_user_command("LspFormatRegion", function()
  local r = vim.lsp.util.make_given_range_params()
  local line1 = r.range.start.line + 1
  local line2 = r.range["end"].line + 1
  vim.lsp.buf.format({ range = { start = { line1, 0 }, ["end"] = { line2, 0 } } })
end, { range = 2 })

vim.api.nvim_create_user_command("LineDiagnostic", function()
  local opts = {
    focusable = true,
    border = "rounded",
    prefix = "",
  }
  local _, winid = vim.diagnostic.open_float(nil, opts)
  if winid and vim.api.nvim_win_is_valid(winid) then
    vim.api.nvim_win_set_height(winid, 5)
    vim.api.nvim_win_set_width(winid, 60)
  end
end, {})

vim.api.nvim_create_user_command("JsonFormatRegion", function(opts)
  vim.cmd(string.format("silent  %d,%d !prettier --stdin-filepath=1.json", opts.line1, opts.line2))
end, { range = 2 })

vim.api.nvim_create_user_command("XmlFormatRegion", function(opts)
  vim.cmd(string.format("silent  %d,%d !prettier --stdin-filepath=1.html --print-width=1000", opts.line1, opts.line2))
end, { range = 2 })

vim.api.nvim_create_user_command("ClangFormatRegion", function(opts)
  vim.cmd(string.format("silent %d,%d ! clang-format", opts.line1, opts.line2))
end, { range = 2 })


vim.api.nvim_create_user_command("MarkdownFormatCodeBlock", require("tools.markdown_formater.markdown").format_region, {})

vim.api.nvim_create_user_command("HexView", require('edit.setup.hex-view').view, { range = 2 })
