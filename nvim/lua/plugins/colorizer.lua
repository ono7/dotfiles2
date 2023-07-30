local ok, config = pcall(require, 'colorizer')

if not ok then
  print('colozirer.lua not loaded')
  return
end

config.setup {
  filetypes            = { 'lua', 'css', 'html', 'scss' },
  user_default_options = {
    css = true,
    css_fn = true,
    names = true,
    mode = "virtualtext",
    tailwind = true,
    sass = { enable = false, parsers = { "css" }, },
    virtualtext = "■",
    always_update = true
  },
}
