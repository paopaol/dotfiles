return {
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          cmake = { "cmake_format" },
          proto = { "clang-format" },
          python = { "ruff_format", "ruff_organize_imports" },
          xml = { "xmlformat" },
          json = { "prettier" },
        },
        formatters = {
          xmlformat = {
            prepend_args = { "--selfclose", "--preserve-attribute" },
            -- args = { "--selfclose", "--preserve-attribute", "$FILENAME" },
          },
        },
      })
    end,
  },
}
