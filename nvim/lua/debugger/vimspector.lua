local remap = vim.api.nvim_set_keymap
remap('n', '<f12>', 'call <Plug>VimspectorBalloonEval()',
      {expr = true, noremap = true})
remap('x', '<f12>', 'call <Plug>VimspectorBalloonEval()',
      {expr = true, noremap = true})

vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'
vim.cmd([[
  nmap <f12> <Plug>VimspectorBalloonEval
  xmap <f12> <Plug>VimspectorBalloonEval
]])
