local ok, config = pcall(require, "nvim-highlight-colors")

if not ok then
  print('hl_cloars.lua not loaded')
  return
end

lua

config.setup {
  render = 'background', -- or 'foreground' or 'first_column'
  enable_named_colors = true,
  enable_tailwind = false,
  custom_colors = {
    -- label property will be used as a pattern initially(string.gmatch), therefore you need to escape the special characters by yourself with %
    { label = '%-%-theme%-font%-color', color = '#fff' },
  }

}
require('nvim-highlight-colors').setup {}
