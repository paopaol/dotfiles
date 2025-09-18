return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		cmd = { "DapNew", "DapContinue" },
		config = require("debugger.setup.dap").config,
		keys = {
			{ '<F5>',  function() require('dap').continue() end },
			{ '<F7>',  require('debugger.setup.dap').preview },
			{ '<F8>',  require('debugger.setup.dap').scopes },
			{ '<F9>',  function() require('dap').toggle_breakpoint() end },
			{ '<F10>', function() require('dap').step_over() end },
			{ '<F11>', function() require('dap').step_into() end },
			{ '<F12>', require('debugger.setup.dap').hover },
		}
	},
}
