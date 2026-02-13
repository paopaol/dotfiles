return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          cmake = { "cmake_format" },
          python = { "ruff_format", "ruff_organize_imports" },
        },
      })
    end,
  },
}
