local oil_ok, oil_config = pcall(require, "oil")

if not oil_ok then
  print("Error in pcall oil -> ~/.dotfiles/nvim/lua/plugins/oil.lua")
  return
end


oil_config.setup {
  columns = { "icon" },
  -- keymaps = {
  --   ["<C-h>"] = false,
  --   ["<M-h>"] = "actions.select_split",
  -- },
  view_options = {
    show_hidden = true,
  },
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = true,

  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = false
}

-- Open parent directory in current window
vim.keymap.set("n", "<space>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "-", require("oil").toggle_float)
