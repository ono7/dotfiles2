local status_ok, config = pcall(require, "nightfox")

if not status_ok then
  print("problem loading nightfox theme")
  return
end

config.setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,                -- Disable setting background
    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,              -- Non focused panes set to alternative background
    module_default = true,             -- Default enable value for modules
    styles = {
                                       -- Style to be applied to different syntax groups
      comments = "NONE",               -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {
                -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")

vim.api.nvim_set_hl(0, "MatchParen", { link = "Search" })
vim.api.nvim_set_hl(0, "@field", { link = "Normal" })
vim.api.nvim_set_hl(0, "@method.call", { link = "Normal" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#39506d" })
vim.api.nvim_set_hl(0, "Identifier", {}) -- clear
vim.api.nvim_set_hl(0, "@keyword.operator", { link = "@conditional" })
vim.api.nvim_set_hl(0, "@string.escape", { fg = "#e0c989" })
vim.api.nvim_set_hl(0, "markdownH1", { link = "CursorLineNr" })
vim.api.nvim_set_hl(0, "markdownH2", { link = "Question" })
vim.api.nvim_set_hl(0, "markdownH3", { link = "NvimTreeRootFolder" })
vim.api.nvim_set_hl(0, "Whitespace", { link = "Error" })
vim.api.nvim_set_hl(0, "LineNr", { link = "SpecialKey" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- transparent bg for floats
vim.api.nvim_set_hl(0, "Winbar", { bold = false, link = "Comment", bg = "none" })
vim.api.nvim_set_hl(0, "MsgSeparator", { link = "Comment" })
vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Visual" })
