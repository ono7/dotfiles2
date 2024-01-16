-- inspired by `go doc http | bat -l go`, the bat cat replacement
-- colors there look sweet

-- NOTE(jlima): background = "0x1e293b" this background makes this theme standout
-- currently the background is set in alacritty colorscheme


local mycolors = {
  white = "#D9E0EE",
  bright_white = "#ffffff",
  darker_black = "#191828",
  black = "#1E1D2D",   --  nvim bg
  black2 = "#252434",
  one_bg = "0x1e293b", -- bg for this theme (jlima)
  one_bg2 = "#363545",
  one_bg3 = "#3e3d4d",
  grey = "#474656",
  grey_fg = "#4e4d5d",
  grey_fg2 = "#555464",
  light_grey = "#605f6f",
  red = "#F38BA8",
  baby_pink = "#ffa5c3",
  pink = "#F5C2E7",
  line = "#383747", -- for lines like vertsplit
  vibrant_green = "#b6f4be",
  nord_blue = "#8bc2f0",
  blue = "#9DBBF4",
  yellow = "#FAE3B0",
  sun = "#ffe9b6",
  purple = "#d0a9e5",
  dark_purple = "#c7a0dc",
  orange = "#F8BD96",
  teal = "#89DCEB",
  cyan = "#89DCEB",
  statusline_bg = "#232232",
  lightbg = "#2f2e3e",
  pmenu_bg = "#ABE9B3",
  folder_bg = "#9DBBF4",
  lavender = "#c7d1ff",
  green = "#ceeac8",
  mauve = "#caa1fd"
}

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
    bright_green  = "#B3E053",
    green         = "#B3E053",
    orange        = "#ef9c40",
    GruvboxOrange = "#ef9c40",
    GruvboxRed    = "#e53f73",
  },
  overrides = {
    String = { fg = "#E4DB82" },
    Normal = { fg = "#ffffff" },
    ModeMsg = { fg = "#ffffff" },
    GruvboxFg1 = { fg = "#ffffff" },
    Variable = { fg = "#ffffff" },
    Punctuation = { fg = "#ffffff" },
    Constant = { fg = "#ffffff" },
    CursorLineNr = { fg = "#ffffff", bg = "none" },
    LineNr = { fg = "#4a483f", bg = "none" },
    Number = { fg = "#B586F8" },
    Float = { fg = "#B586F8" },
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
    ["@string.escape"] = { fg = "#B586F8" },
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
vim.api.nvim_set_hl(0, "cmpSelect", { bg = mycolors.baby_pink, fg = mycolors.darker_black })
vim.api.nvim_set_hl(0, "WildMenu", { bg = "#29354a" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#29354a" })
vim.api.nvim_set_hl(0, "WildMenuSelect", { bg = mycolors.baby_pink, fg = mycolors.darker_black })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Comment" })
vim.api.nvim_set_hl(0, "cmpBorder", { fg = "#2b2c36" })
vim.api.nvim_set_hl(0, "MatchParen", { bg = "#43536d", fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#2b3b55" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2b3b55" })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ceeac8" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#9eb0ce", fg = "#000000" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#444d69" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#8186a1" })
vim.api.nvim_set_hl(0, "Winbar", { fg = "#a89984" })
vim.api.nvim_set_hl(0, "WinbarNc", { fg = "#a89984" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#242438" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#474a59" })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#8186a1", undercurl = true })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#8186a1" })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "Folded", { link = "Comment" })
vim.api.nvim_set_hl(0, "Error", { fg = "#e53f73", bg = "none" })
vim.api.nvim_set_hl(0, "MsgSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#2f5293" })
vim.api.nvim_set_hl(0, "Search", { bg = "#2f5293", })
vim.api.nvim_set_hl(0, "@method.call", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#29354a" })
vim.api.nvim_set_hl(0, "GruvboxOrange", { fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "JinjaVarBlock", { fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "JinjaVarDelim", { fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "JinjaTagBlock", { fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "JinjaTagDelim", { fg = "#ef9c40" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2b3b55" })
