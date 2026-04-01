local M = {}
local lang_conf = {}

lang_conf["markdown"] = { "```", "```" }
lang_conf["vimwiki"] = { "{{{", "}}}" }
lang_conf["norg"] = { "@code", "@end" }
lang_conf["org"] = { "#+BEGIN_SRC", "#+END_SRC" }
lang_conf["markdown.pandoc"] = { "```", "```" }

M.lang_conf = lang_conf

M.format_options = {
  c = {
    format = clang_format_region,
    language_code = "c",
  },
  cpp = {
    format = clang_format_region,
    language_code = "cpp",
  },
  json = {
    format = json_format_region,
    language_code = "json",
  },
  xml = {
    format = xml_format_region,
    language_code = "xml",
  },
  lua = {
    format = { "lua" },
    language_code = "lua",
  },
  haskell = {
    format = { "ghc" },
    language_code = "haskell",
  },
  js = {
    format = { "node" },
    language_code = "js",
  },
  ocaml = {
    format = { "ocamlc" },
    language_code = "ocaml",
  },
  python = {
    format = { "python3" },
    language_code = { "python", "py" },
  },
  ruby = {
    format = { "ruby" },
    language_code = "ruby",
  },
  rust = {
    format = { "rustc" },
    language_code = "rust",
  },
}

return M
