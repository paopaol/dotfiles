return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          cmake = { "cmake_format" },
          proto = { "clang-format" },
          python = { "ruff_format", "ruff_organize_imports" },
          xml = { "xmlformat" },
          json = { "prettier" },
          fbs = { "flatbuffers_format" },
        },
        formatters = {
          xmlformat = {
            prepend_args = { "--selfclose", "--preserve-attribute" },
          },
          flatbuffers_format = {
            command = "flatbuffers-format",
            args = { "--stdin-filepath", "$FILENAME", "-" },
            stdin = true,
          },
        },
      })
    end,
  },
}
