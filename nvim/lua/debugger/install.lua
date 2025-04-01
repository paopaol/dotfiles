return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
    config = require("debugger.setup.dap").confg,
    keys = {
      { '<F5>',  function() require('dap').continue() end },
      { '<F9>',  function() require('dap').toggle_breakpoint() end },
      { '<F10>', function() require('dap').step_over() end },
      { '<F11>', function() require('dap').step_into() end },
      { '<F12>', function() require('debugger.setup.dap').hover() end },
    }
  },
}
