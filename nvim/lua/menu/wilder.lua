local wilder = require('wilder')

wilder.setup({ modes = { ':', '/', '?' },
  next_key = '<C-j>',
  previous_key = '<C-k>',
  accept_key = '<Tab>',
  reject_key = '<C-c>',
})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      file_command = { 'fd', '-tf' },
      dir_command = { 'fd', '-tf' },
      filters = { 'fuzzy_filter', 'difflib_sorter' },
    }),
    wilder.cmdline_pipeline(),
    wilder.python_search_pipeline()
  ),
})

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    min_width = '100%', -- minimum height of the popupmenu, can also be a number
    max_height = '25%',
    reverse = 0, -- if 1, shows the candidates from bottom to top
  })
))
