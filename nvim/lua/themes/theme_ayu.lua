vim.o.background = "dark"

local status_ok, config = pcall(require, "ayu")

if not status_ok then
  print("problem loading ayu theme")
  return
end

config.setup({
  mirage = true,                                                                            -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
  overrides = { Normal = { bg = "#212733", fg = "#e6e1cf" }, String = { fg = "#b8cc52" } }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
  -- overrides = { Normal = { bg = "none" , fg = "#e6e1cf" }, String = { fg = "#b8cc52" } }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
  options = {
    theme = "ayu",
  },
})

require("ayu").colorscheme()

vim.api.nvim_set_hl(0, "MatchParen", { bg = "#323a4c", fg = "#ffa759", bold = true, underline = true })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "@variable", { link = "Normal" })
vim.api.nvim_set_hl(0, "@function.call", { link = "Normal" })
vim.api.nvim_set_hl(0, "Error", { fg = "#f27983" })
vim.api.nvim_set_hl(0, "@field", { link = "Normal" })
vim.api.nvim_set_hl(0, "@text.literal", { link = "Normal" })
vim.api.nvim_set_hl(0, "VertSplit", { link = "Comment" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "NonText" })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#f27983", italic = true })
vim.api.nvim_set_hl(0, "Repeat", { italic = true })
vim.api.nvim_set_hl(0, "@conditional", { italic = true })
vim.api.nvim_set_hl(0, "@keyword.function", { italic = true, fg = "#f27983" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6773", italic = false })
vim.api.nvim_set_hl(0, "@field", { link = "Error" })
vim.api.nvim_set_hl(0, "MsgSeparator", { link = "Error" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Comment" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "NonText" })
vim.api.nvim_set_hl(0, "QuickFixLine", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { link = "Comment" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { link = "@boolean" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6773" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
