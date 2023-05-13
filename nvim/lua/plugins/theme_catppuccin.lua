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
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
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
  color_overrides = {},
  custom_highlights = {},
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

-- require("catppuccin").remap({
--  ErrorMsg = { fg = cp.red, style = "bold" },
--  TSProperty = { fg = cp.yellow, style = "NONE" },
--  TSInclude = { fg = cp.teal, style = "NONE" },
--  TSOperator = { fg = cp.sky, style = "bold" },
--  TSKeywordOperator = { fg = cp.sky, style = "bold" },
--  TSPunctSpecial = { fg = cp.maroon, style = "bold" },
--  TSFloat = { fg = cp.peach, style = "bold" },
--  TSNumber = { fg = cp.peach, style = "bold" },
--  TSBoolean = { fg = cp.peach, style = "bold" },
--  TSConditional = { fg = cp.mauve, style = "bold" },
--  TSRepeat = { fg = cp.mauve, style = "bold" },
--  TSException = { fg = cp.peach, style = "NONE" },
--  TSConstBuiltin = { fg = cp.lavender, style = "NONE" },
--  TSFuncBuiltin = { fg = cp.peach, style = "NONE" },
--  TSTypeBuiltin = { fg = cp.yellow, style = "NONE" },
--  TSVariableBuiltin = { fg = cp.teal, style = "NONE" },
--  TSFunction = { fg = cp.blue, style = "NONE" },
--  TSParameter = { fg = cp.rosewater, style = "NONE" },
--  TSKeywordFunction = { fg = cp.maroon, style = "NONE" },
--  TSKeyword = { fg = cp.red, style = "NONE" },
--  TSMethod = { fg = cp.blue, style = "NONE" },
--  TSNamespace = { fg = cp.rosewater, style = "NONE" },
--  TSStringRegex = { fg = cp.peach, style = "NONE" },
--  TSVariable = { fg = cp.white, style = "NONE" },
--  TSTagAttribute = { fg = cp.mauve, style = "NONE" },
--  TSURI = { fg = cp.rosewater, style = "underline" },
--  TSLiteral = { fg = cp.teal, style = "NONE" },
--  TSEmphasis = { fg = cp.maroon, style = "NONE" },
--  TSStringEscape = { fg = cp.pink, style = "NONE" },
--  bashTSFuncBuiltin = { fg = cp.red, style = "NONE" },
--  bashTSParameter = { fg = cp.yellow, style = "NONE" },
--  typescriptTSProperty = { fg = cp.lavender, style = "NONE" },
--  cssTSProperty = { fg = cp.yellow, style = "NONE" }
--})

vim.cmd.colorscheme("catppuccin")

-- setup must be called before loading
vim.api.nvim_set_hl(0, "@conceal", { link = "Comment" })
vim.api.nvim_set_hl(0, "TreesitterContext", { link = "DiffText" })
vim.api.nvim_set_hl(0, "Visual", { link = "Search" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "NonText" })
-- vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#cba6f7", italic = true })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#cba6f7", italic = true })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#cba6f7", italic = true })
vim.api.nvim_set_hl(0, "@method.call.go", { link = "Normal" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f38ba8" , bold = true})
