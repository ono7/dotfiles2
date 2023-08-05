local ok, config = pcall(require, 'live-server')

if not ok then
  print("live server not loaded")
  return
end

config.setup({
  args = { '--port=7000' }
})
