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

-- 超大文件（>5000 行）关闭语法高亮，避免打开和滚动时卡顿（阈值与 lsp/clangd.lua 一致）
local big_file = function(bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 5000
end

-- 彩虹括号：插件自带的按 buffer 开关
vim.g.rainbow_delimiters = {
  condition = function(bufnr)
    return not big_file(bufnr)
  end,
}

-- treesitter 高亮由 after/ftplugin/*.lua 启动，且 ftplugin 先于本 autocmd 执行，故此处直接关掉
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("big-file-highlight-group", { clear = true }),
  callback = function(args)
    if big_file(args.buf) then
      vim.treesitter.stop(args.buf)
    end
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
