local live_server_ok, config = pcall(require, "live-server")
if not live_server_ok then
  print("Error in pcall live-server -> ~/.dotfiles/nvim/lua/plugins/live_server.lua")
  return
end

config.setup({
  args = { '--port=7000' }
})
