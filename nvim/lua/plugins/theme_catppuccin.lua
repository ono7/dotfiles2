local status_ok, config = pcall(require, "catppuccin")

if not status_ok then
  print("problem loading catppuccin theme")
  return
end


config.setup({
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
  color_overrides = {
    -- see link below for override names
    -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
    mocha = {
      -- green = "#ceeac8",
      green = "#b2d6a9",
      -- mauve = "#8174d3"
      mauve = "#caa1fd"
    }
  },
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    neotree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

vim.cmd.colorscheme("catppuccin")

-- vim.api.nvim_set_hl(0, "ErrorMsg", { fg = "#e27e8d" })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#4D5967" })
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#d8e2ec" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "Function", { fg = "#9abdf5" })
-- vim.api.nvim_set_hl(0, "@conceal", { link = "Comment" })
vim.api.nvim_set_hl(0, "Search", { bg = "#3e4b6b" })
-- vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Search" })
vim.api.nvim_set_hl(0, "Folded", { fg = "#3e404c", bold = true })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#242438" })
vim.api.nvim_set_hl(0, "Visual", { link = "Search" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#2b2c36", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiffChange", {})
-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#bb9af7" })
-- vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#bb9af7", italic = true })
-- vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#9d7cd8", italic = true })
-- vim.api.nvim_set_hl(0, "@method.call.go", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#737aa2", bold = true })
vim.api.nvim_set_hl(0, "@text.todo", { link = "ErrorMsg" })
vim.api.nvim_set_hl(0, "@field", {})
-- vim.api.nvim_set_hl(0, "FloatShadow", {})
-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "NormalNC" })
-- vim.api.nvim_set_hl(0, "GitSignsChange", { link = "Constant" })
-- vim.api.nvim_set_hl(0, "MatchParen", { link = "Visual" })
-- vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = "#e27e8d" })
-- vim.api.nvim_set_hl(0, "@parameter", { fg = "#e27e8d" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#41505e" })
