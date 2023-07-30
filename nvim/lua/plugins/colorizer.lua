local ok, config = pcall(require, 'colorizer')

if not ok then
  print('colozirer.lua not loaded')
  return
end

config.setup {
  'javascript',
  'lua',
  'css',
  css  = {
    rgb_fn = true,         -- CSS rgb() and rgba() functions
    names  = true,
    hsl_fn = true,         -- CSS hsl() and hsla() functions
    css    = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true,         -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode   = 'background', -- Set the display mode.
  },
  html = {
    mode = 'foreground',
  }
}
