vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "复制后高亮显示内容",
  group = vim.api.nvim_create_augroup("highlight-yank-group", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("im-select-group", { clear = true }),
  callback = function()
    if vim.fn.has("win32") == 1 then
      vim.fn.system("im-select 1033")
    elseif vim.fn.has("wsl") == 1 then
      vim.fn.system("/mnt/c/Windows/System32/im-select.exe 1033")
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("toggleterm-group", { clear = true }),
  pattern = "term://*", -- 匹配所有终端
  callback = function()
    local opts = { buffer = 0 }

    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("n", "<A-h>", [[]], opts)
    vim.keymap.set("n", "<A-j>", [[]], opts)
    vim.keymap.set("n", "<A-k>", [[]], opts)
    vim.keymap.set("n", "<A-l>", [[]], opts)
    vim.keymap.set("t", "<C-j>", [[<Down>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Up>]], opts)
    vim.keymap.set("n", "<C-o>", [[]], opts)
    vim.keymap.set("n", "<C-i>", [[]], opts)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "visual_multi_exit",
  callback = function()
    vim.keymap.set("i", "<CR>", function()
      local cmp = require("blink.cmp")
      if cmp.is_visible() then
        cmp.select_and_accept()
        return ""
      else
        return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
      end
    end, { expr = true, silent = true })
  end,
})
