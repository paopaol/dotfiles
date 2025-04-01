return {
  { "skywind3000/asynctasks.vim", event = "VeryLazy", cmd = { 'AsyncTask', 'AsyncTaskEdit' } },

  {
    "skywind3000/asyncrun.vim",
    event = "VeryLazy",
    dependencies = {
      "skywind3000/asynctasks.vim"
    },
    cmd = { 'AsyncRun', 'AsyncStop', 'AsyncTaskEdit' },
    config = function()
      vim.cmd([[
          if has('win32')
            let g:asyncrun_encs = 'gbk'
          endif
        ]])

      vim.g.asyncrun_rootmarks = {
        '.projectile'
      }
      vim.g.asyncrun_open = 15
      vim.g.asyncrun_save = 2

      vim.g.asyncrun_runner = {
        mytoggleterm = function(opts)
          vim.cmd(string.format("TermExec cmd='%s' dir='%s'", opts.cmd, opts.macros.VIM_ROOT))
        end
      }
    end,
  },
}
