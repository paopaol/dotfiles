local defaults = require("tools.markdown_formater.defaults")

local M = {}

local function code_block_start()
  return defaults.lang_conf[vim.bo.filetype][1]
end

local function code_block_end()
  return defaults.lang_conf[vim.bo.filetype][2]
end

-- Parses start line to get code of the language.
-- For example: `#+BEGIN_SRC cpp` returns `cpp`.
function get_lang(start_line)
  local start_pos = string.find(start_line, code_block_start())
  local len = string.len(code_block_start())
  return string.sub(start_line, start_pos + len):gsub("%s+", "")
end

M.format_region = function()
  if vim.o.filetype ~= "markdown" then
    return
  end

  local currnet_pos = vim.fn.getpos(".")
  local old_line_nr = currnet_pos[2]

  local linenr_from = vim.fn.search(code_block_start() .. ".\\+$", "bnW")

  currnet_pos[2] = linenr_from
  vim.fn.setpos(".", currnet_pos)
  currnet_pos[2] = old_line_nr

  local linenr_until = vim.fn.search(code_block_end() .. "s*$", "nW")
  if linenr_from == 0 or linenr_until == 0 or currnet_pos[2] > linenr_until then
    vim.fn.setpos(".", currnet_pos)
    print("Not inside a code block.")
    return
  end

  local start_line = vim.fn.getline(linenr_from)
  local lang_code = get_lang(start_line)
  if lang_code == "" then
    vim.fn.setpos(".", currnet_pos)
    print("Language is not defined.")
    return
  end

  defaults.format_options[lang_code].format({ line1 = linenr_from + 1, line2 = linenr_until - 1 })

  vim.fn.setpos(".", currnet_pos)
end

vim.api.nvim_create_user_command("MarkdownFormatCodeBlock", M.format_region, {})

return M
