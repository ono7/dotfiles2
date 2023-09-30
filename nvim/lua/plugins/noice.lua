local notify_ok, notify_exec = pcall(require, "notify")
if not notify_ok then
  print("Error in pcall notify -> ~/.dotfiles/nvim/lua/plugins/notify.lua")
  return
end

vim.notify = notify_exec
