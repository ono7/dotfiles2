local notify_ok, notify_exec = pcall(require, "notify")
if not notify_ok then
  print("Error in pcall notify -> ~/.dotfiles/nvim/lua/plugins/notify.lua")
  return
end

require("notify").setup({
  background_colour = "#000000",
})

vim.notify = notify_exec
