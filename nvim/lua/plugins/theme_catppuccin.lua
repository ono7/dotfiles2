-- local cp = require 'catppuccin.utils.colors'.get_colors()

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
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
  no_italic = false, -- Force no italic
  no_bold = false,   -- Force no bold
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
  color_overrides = {},
  -- custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

vim.cmd.colorscheme("catppuccin")

-- setup must be called before loading
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#e27e8d" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#4D5967" })
vim.api.nvim_set_hl(0, "Normal", { fg = "#d8e2ec" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "Function", { fg = "#8EAAF4" })
vim.api.nvim_set_hl(0, "Function", { fg = "#9abdf5" })
vim.api.nvim_set_hl(0, "@conceal", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "TreesitterContext", { link = "DiffText" })
vim.api.nvim_set_hl(0, "Search", { bg = "#33415e" })
vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Search" })
vim.api.nvim_set_hl(0, "Folded", { link = "Comment" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#33415e" })
vim.api.nvim_set_hl(0, "Visual", { link = "Search" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#26323b", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", {})
-- vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#bb9af7", italic = true })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#bb9af7" })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#bb9af7", italic = true })
-- vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#8d7cd8", italic = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#9d7cd8", italic = true })
vim.api.nvim_set_hl(0, "@method.call.go", { link = "Normal" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#737aa2", bold = true })
-- vim.api.nvim_set_hl(0, "String", { fg = "#c5dea1" })
vim.api.nvim_set_hl(0, "String", { fg = "#b6d68a" })
vim.api.nvim_set_hl(0, "@text.todo", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1d252c" })
vim.api.nvim_set_hl(0, "PmenuSel", { link = "Search" })
vim.api.nvim_set_hl(0, "@field", {})
vim.api.nvim_set_hl(0, "FloatShadow", {})
vim.api.nvim_set_hl(0, "NormalFloat", { link = "NormalNC"})
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "Constant"})
vim.api.nvim_set_hl(0, "@variable.builtin.python", {fg = "#e27e8d"})
vim.api.nvim_set_hl(0, "@parameter", {fg = "#e27e8d"})
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#192028" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#192028" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#41505e" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1d252c" })
-- vim.api.nvim_set_hl(0, "WinbarNC", { bg = "#1d252c" })
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#1d252c", fg = "#1d252c" })
