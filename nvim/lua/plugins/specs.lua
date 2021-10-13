require('specs').setup {
  show_jumps = true,
  min_jump = 30,
  popup = {
    delay_ms = 100, -- delay before popup displays
    inc_ms = 100, -- time increments used for fade/resize effects 
    blend = 100, -- starting blend, between 0-100 (fully transparent), see :h winblend
    width = 100,
    winhl = "PMenu",
    fader = require('specs').linear_fader,
    resizer = require('specs').shrink_resizer
  },
  ignore_filetypes = {},
  ignore_buftypes = {nofile = true}
}
