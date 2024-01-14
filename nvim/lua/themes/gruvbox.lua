-- inspired by `go doc http | bat -l go`, the bat cat replacement
-- colors there look sweet
require("gruvbox").setup({
  terminal_colors = false, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,    -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {
    bright_green = "#B3E053",
    green = "#B3E053",
    orange = "#ef9c40"
  },
  overrides = {
    String = { fg = "#E4DB82" },
    Normal = { fg = "#ffffff" },
    Variable = { fg = "#ffffff" },
    Punctuation = { fg = "#ffffff" },
    Constant = { fg = "#ffffff" },
    CursorLineNr = { fg = "#ffffff", bg = "none" },
    LineNr = { fg = "#4a483f", bg = "none" },
    ["@field"] = { fg = "#ffffff", bg = "none" },
    ["@parameter"] = { fg = "#ef9c40", bg = "none" },
    ["@lsp.type.property"] = { fg = "#ffffff", bg = "none" },
    ["@punctuation.delimiter"] = { fg = "#ffffff" },
    ["@variable"] = { fg = "#ffffff" },
    ["@keyword.function"] = { fg = "#84D6EC" },
    ["@type"] = { fg = "#84D6EC" },
    ["@method"] = { fg = "#84D6EC" },
    ["@method.call"] = { fg = "#B3E053" },
    Type = { fg = "#84D6EC" },
    ["@punctuation.bracket"] = {},
    ["@constructor"] = {},
    ["@type.builtin"] = { fg = "#B3E053" },
    ["@function.call"] = { fg = "#B3E053" },
    ["@number"] = { fg = "#B586F8" },
    ["@boolean"] = { fg = "#B586F8" },
    Boolean = { fg = "#B586F8" },
    ["Operator"] = { fg = "#B586F8" },
    ["@constant.builtin"] = { fg = "#B586F8" },
    ["@keyword.return"] = { fg = "#e53f73" },
    ["@conditional"] = { fg = "#e53f73" },
    ["@repeat"] = { fg = "#e53f73" },
    ["@include"] = { fg = "#e53f73" },
    ["@operator"] = { fg = "#e53f73" },
    ["Comment"] = { fg = "#747160" },
    Conditional = { fg = "#e53f73" },
    ErrorMsg = { fg = "#e53f73", bg = "none" },
    ["@text.todo"] = { link = "ErrorMsg" },
    ["@text.danger.comment"] = { link = "ErrorMsg" },
    ["@text.note.comment"] = { link = "Normal" },
    Keyword = { fg = "#84D6EC" },
  },
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")
