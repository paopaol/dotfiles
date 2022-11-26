local options = {
  styles = {
    comments = "italic,bold",
    functions = "bold",
    keywords = "bold",
    numbers = "bold",
    operators = "bold",
    strings = "bold",
    types = "bold",
    variables = "italic,bold",
    constants = "bold",
    conditionals = "bold",
  }
}



local palettes = {
  all = {
    red = "#ff0000",
  },
  nightfox = {
    red = "#c94f6d",
  },
  dayfox = {
    blue = { base = "#4d688e", bright = "#4e75aa", dim = "#485e7d" },
    bg1 = "#ffffff",
  },

  nordfox = {
    bg1 = "#2e3440",
    sel0 = "#3e4a5b", -- Popup bg, visual selection bg
    sel1 = "#4f6074", -- Popup sel bg, search bg
    comment = "#60728a",
  },
}

local specs = {
  all = {
    git = {
      changed = "#f4a261",

    },
  },
  dayfox = {
    syntax  = {
      keyword     = "#00cc00",
      type        = "seagreen",
      func        = "purple",
      field       = "black",
      operator    = "red",
      bracket     = "red",
      string      = "deeppink",
      builtin0    = "red",
      builtin1    = "#00cc00", --Builtin type
      builtin2    = "#00cc00", --Builtin variable
      ident       = "darkcyan", -- class method
      preproc     = "red",
      variable    = "blue",
      const       = "red",
      conditional = "red",
      statement   = "red",
      number      = "purple",
    },
    diag_bg = "white",
  },
}

local groups = {
  all = {
    Whitespace = { link = "Comment" },
    IncSearch = { bg = "palette.cyan" },
  },
  nightfox = {
    PmenuSel = { bg = "#73daca", fg = "bg0" },
  },
}


require("nightfox").setup({ palettes = palettes, specs = specs, groups = groups, options = options })
