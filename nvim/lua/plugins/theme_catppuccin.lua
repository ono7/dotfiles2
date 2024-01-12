local status_ok, config = pcall(require, "catppuccin")

if not status_ok then
  print("problem loading catppuccin theme")
  return
end

local mycolors = {
  white = "#D9E0EE",
  darker_black = "#191828",
  black = "#1E1D2D",  --  nvim bg
  black2 = "#252434",
  one_bg = "#2d2c3c", -- real bg of onedark
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
  -- green = "#ABE9B3",
  vibrant_green = "#b6f4be",
  nord_blue = "#8bc2f0",
  blue = "#9DBBF4",
  yellow = "#FAE3B0",
  sun = "#ffe9b6",
  purple = "#d0a9e5",
  dark_purple = "#c7a0dc",
  -- teal = "#B5E8E0",
  -- tael = "#86C9C0",
  orange = "#F8BD96",
  teal = "#89DCEB",
  cyan = "#89DCEB",
  statusline_bg = "#232232",
  lightbg = "#2f2e3e",
  pmenu_bg = "#ABE9B3",
  folder_bg = "#9DBBF4",
  lavender = "#c7d1ff",
  -- my overrides --
  green = "#ceeac8",
  -- green = "#b2d6a9",
  -- mauve = "#8174d3"
  mauve = "#caa1fd"
}

config.setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  type = "dark",
  background = {
    -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = true, -- Force no italic
  no_bold = false,  -- Force no bold
  styles = {
    comments = {},
    conditionals = { "italic" },
    loops = { "italic" },
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = { "italic" },
    parameters = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {
    -- see link below for override names
    -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
    mocha = mycolors,
  },
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    neotree = false,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll doln (https://github.com/catppuccin/nvim#integrations)
  },
})

vim.cmd.colorscheme("catppuccin")

-- vim.api.nvim_set_hl(0, "Search", { bg = "#3e4b6b" })
-- vim.api.nvim_set_hl(0, "IncSearch", { fg = "#b2d6a9", reverse = true })
vim.api.nvim_set_hl(0, "Folded", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "Visual", { link = "Search" })
-- vim.api.nvim_set_hl(0, "DiffChange", {})
-- vim.api.nvim_set_hl(0, "@field", {})

vim.api.nvim_set_hl(0, "TreesitterContextBottom", { fg = "#B0A0FF", bold = true, italic = true })
-- vim.api.nvim_set_hl(0, "String", { fg = "#B0A0FF" })
-- vim.api.nvim_set_hl(0, "@text.literal", { fg = "#94a1c2", bold = true })
vim.api.nvim_set_hl(0, "@text.todo", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@text.danger", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@text.note", { link = "Normal" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#242438" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#8186a1" })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#8186a1", undercurl = true })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#2b3b55" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2b3b55" })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ceeac8" })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#8bc2f0" })
vim.api.nvim_set_hl(0, "@property", { fg = "#ffa5c3" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#c7d1ff" })
vim.api.nvim_set_hl(0, "@type", { fg = "#D9E0EE", bold = false })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#D9E0EE" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#2f5293" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = mycolors.green, fg = "#000000" })
vim.api.nvim_set_hl(0, "Search", { bg = "#2f5293" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#444d69" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#8186a1" })
vim.api.nvim_set_hl(0, "@function", {})
vim.api.nvim_set_hl(0, "@property", {})
-- vim.api.nvim_set_hl(0, "Type", {})
-- vim.api.nvim_set_hl(0, "@type.builtin", { fg = mycolors.yellol })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = mycolors.mauve, italic = true })
-- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#1B192C" })
vim.api.nvim_set_hl(0, "NeoTreeNormal", {})
vim.api.nvim_set_hl(0, "MatchParen", { fg = "#fab387", bold = true })
vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#1B192C" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Comment" })
vim.api.nvim_set_hl(0, "cmpBorder", { fg = "#2b2c36" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#474a59" })
vim.api.nvim_set_hl(0, "cmpDoc", { bg = "#1B192C" })
vim.api.nvim_set_hl(0, "cmpSelect", { bg = mycolors.baby_pink, fg = mycolors.darker_black })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = mycolors.baby_pink, bold = false, underline = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "Comment" })
