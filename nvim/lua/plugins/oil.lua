local oil_ok, oil_config = pcall(require, "oil")

if not oil_ok then
  print("Error in pcall oil -> ~/.dotfiles/nvim/lua/plugins/oil.lua")
  return
end


oil_config.setup {
  columns = { "icon" },
  keymaps = {
    ["<C-h>"] = false,
    ["<M-h>"] = "actions.select_split",
  },
  view_options = {
    show_hidden = true,
  },
}

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<space>-", require("oil").toggle_float)
