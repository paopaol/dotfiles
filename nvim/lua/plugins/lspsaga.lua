local saga = require 'lspsaga'
saga.init_lsp_saga({
  code_action_prompt = {
    enable = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true
  }
})

-- vim.cmd(([[
-- autocmd CursorHold * lua require'lspsaga.diagnostic'.show_line_diagnostics()
-- ]]))
