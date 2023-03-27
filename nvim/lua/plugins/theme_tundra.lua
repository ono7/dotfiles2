require("nvim-tundra").setup({
  transparent_background = true,
  dim_inactive_windows = {
    enabled = false,
    color = nil,
  },
  editor = {
    search = {},
    substitute = {},
  },
  syntax = {
    booleans = { bold = true, italic = true },
    comments = { bold = false, italic = false },
    conditionals = { italic = true },
    constants = { bold = true },
    fields = {},
    functions = {},
    keywords = { italic = true },
    loops = { italic = true },
    numbers = { bold = true },
    operators = { bold = true },
    punctuation = {},
    strings = {},
    types = { italic = true },
  },
  diagnostics = {
    errors = {},
    warnings = {},
    information = {},
    hints = {},
  },
  plugins = {
    lsp = true,
    treesitter = true,
    nvimtree = true,
    cmp = true,
    context = true,
    dbui = true,
    gitsigns = true,
    telescope = true,
  },
  overwrite = {
    colors = {},
    highlights = {},
  },
})

vim.opt.background = "dark"
vim.cmd("colorscheme tundra")
vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" })
vim.api.nvim_set_hl(0, "IncSearch", { link = "Search" })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { link = "DiffChange" })
-- vim.cmd("hi! link MatchParen Visual")
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#fca5a5", bg = "none" })
