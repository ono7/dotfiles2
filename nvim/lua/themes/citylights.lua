local theme = {}

-- Color Palette
theme.palette = {
  -- bg = "#222932",
  fg = "#ABB2BF",
  gray = "#5C6370",
  red = "#E06C75",
  yellow = "#E5C07B",
  green = "#A8D699",
  cyan = "#56B6C2",
  blue = "#61AFEF",
  purple = "#cfbafa",
  orange = "#D19A66",
}

-- Syntax Highlighting Groups
theme.base = {
  -- General
  Normal = { fg = theme.palette.fg, bg = theme.palette.bg },
  Terminal = { fg = theme.palette.fg, bg = theme.palette.bg },
  SignColumn = { fg = theme.palette.fg, bg = theme.palette.bg },
  FoldColumn = { fg = theme.palette.gray, bg = theme.palette.bg },
  EndOfBuffer = { fg = theme.palette.bg },

  -- Cursor
  CursorLine = { bg = theme.palette.gray },
  CursorLineNr = { fg = theme.palette.blue },

  -- Line Numbers
  LineNr = { fg = theme.palette.gray },
  CursorColumn = { bg = theme.palette.gray },

  -- Search
  Search = { fg = theme.palette.bg, bg = theme.palette.yellow },
  IncSearch = { fg = theme.palette.bg, bg = theme.palette.yellow },

  -- Status Line
  StatusLine = { fg = theme.palette.fg, bg = theme.palette.gray },
  StatusLineNC = { fg = theme.palette.gray, bg = theme.palette.bg },

  -- Diff
  DiffAdd = { fg = theme.palette.green, bg = theme.palette.bg },
  DiffChange = { fg = theme.palette.blue, bg = theme.palette.bg },
  DiffDelete = { fg = theme.palette.red, bg = theme.palette.bg },
  DiffText = { fg = theme.palette.yellow, bg = theme.palette.bg },

  -- Spelling
  SpellBad = { fg = theme.palette.red, bg = theme.palette.bg, underline = true },
  SpellCap = { fg = theme.palette.yellow, bg = theme.palette.bg, underline = true },
  SpellLocal = { fg = theme.palette.blue, bg = theme.palette.bg, underline = true },
  SpellRare = { fg = theme.palette.purple, bg = theme.palette.bg, underline = true },
}

-- Apply the color scheme
for group, colors in pairs(theme.base) do
  vim.cmd("highlight " .. group .. " guifg=" .. (colors.fg or "none") .. " guibg=" .. (colors.bg or "none"))
  if colors.underline then
    vim.cmd("highlight " .. group .. " gui=underline")
  end
end
