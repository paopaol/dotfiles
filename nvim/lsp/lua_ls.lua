vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				}
			},
			workspace = {
				library = {
					vim.fn.expand('/home/jz/workspace/jz/dotfiles/wireshark'),
					vim.api.nvim_get_runtime_file("", true),
				},
				checkThirdParty = false, -- 关闭第三方库检测提示
			},
		},
	}
})
