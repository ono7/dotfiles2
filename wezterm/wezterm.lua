local wezterm = require("wezterm")
local scheme = wezterm.get_builtin_color_schemes()['Catppuccin Mocha']
-- from wezterm debug mode see keybinding below
-- https://wezfurlong.org/wezterm/config/lua/wezterm.color/extract_colors_from_image.html
-- [
--     "#2d2e3e",
--     "#e5e693",
--     "#685da5",
--     "#ac68a6",
--     "#a9cee1",
--     "#667684",
--     "#7c527f",
--     "#4c5568",
--     "#8174d3",
--     "#b3da99",
-- ]

--- catpuccine
local ansi = {
  "#45475a",
  "#f38ba8",
  "#ceeac8",
  -- "#bce6b2",
  -- "#f9e2af",
  "#F7CC66",
  "#89b4fa",
  -- "#cba6f7",
  -- "#9581ff",
  "#b0a0ff",
  "#94e2d5",
  "#bac2de",
}

-- local ansi = {
--   "#161616",
--   "#ED6C6C",
--   "#ceeac8",
--   -- "#C1FCC2",
--   "#F7CC66",
--   "#8BABFA",
--   "#B0A0FF",
--   "#94e2d5",
--   "#ADADAD",
-- }

-- my color overrides
scheme.ansi = ansi
scheme.brights = ansi
-- scheme.background = "#161616"
-- scheme.cursor_bg = "#00acc1"
scheme.cursor_bg = "#ff6efd"
local act = wezterm.action

-- local colors, metadata = wezterm.color.load_scheme("~/.config/wezterm/theme_ayu.toml")
return {
  default_prog                               = { "/bin/zsh", "--login" },
  audible_bell                               = "Disabled",
  use_dead_keys                              = false,
  scrollback_lines                           = 10000,
  scroll_to_bottom_on_input                  = true,
  unicode_version                            = 14,
  default_cwd                                = wezterm.homedir,
  disable_default_key_bindings               = true,
  keys                                       = {
    -- use xxd -psd to get hex char sequences
    -- CTRL-SHIFT-l activates the debug overlay
    -- {
    --   key = 'l',
    --   mods = 'CMD',
    --   action = wezterm.action.ShowDebugOverlay
    -- },
    { key = 'C', mods = 'CMD',  action = act.CopyTo 'Clipboard' },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    {
      key = "w",
      mods = "SHIFT|CMD",
      action = act.CloseCurrentPane({ confirm = false }),
    },
    {
      -- turn off cmd+m to minimize window from the os
      key = "m",
      mods = "CMD",
      action = act.DisableDefaultAssignment,
    },
    { key = "h", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "n", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "e", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "i", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "o", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "b", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "d", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "u", mods = "CMD", action = act.DisableDefaultAssignment, },
    { key = "z", mods = "CMD", action = act.DisableDefaultAssignment, },
    {
      -- turn off cmd+h to hide window from the os
      key = "h",
      mods = "CMD",
      action = act.DisableDefaultAssignment,
    },
    {
      -- turn off cmd+m to hide window from the os
      key = "q",
      mods = "CTRL",
      action = act.DisableDefaultAssignment,
    },
    {
      key = "v",
      mods = "CMD",
      action = act.PasteFrom("Clipboard"),
    },
    {
      -- delete word
      key = "Backspace",
      mods = "CMD",
      action = act.SendString("\x17"),
    },
    {
      key = "Backspace",
      mods = "ALT",
      action = act.SendString("\x17"),
    },
    -- make cmd more like control in macos
    { key = "a", mods = "CMD", action = act.SendString("\x01"), },
    { key = "r", mods = "CMD", action = act.SendString("\x12"), },
    { key = "e", mods = "CMD", action = act.SendString("\x05"), },
    { key = "p", mods = "CMD", action = act.SendString("\x10"), },
    { key = "n", mods = "CMD", action = act.SendString("\x0e"), },
    { key = "c", mods = "CMD", action = act.SendString("\x03"), },

    -- neovim terminal
    { key = "t", mods = "CMD", action = act.SendString("\x14"), },

    -- bring back last background task with fg

    { key = "z", mods = "CMD", action = act.SendString("\x1a"), },
    { key = "i", mods = "CMD", action = act.SendString("\x09"), },
    { key = "o", mods = "CMD", action = act.SendString("\x0f"), },

    --- c-u vim, move halfway up
    { key = "u", mods = "CMD", action = act.SendString("\x15"), },
    { key = "]", mods = "CMD", action = act.SendString("\x1d"), },
    { key = "[", mods = "CMD", action = act.SendString("\x1b"), },
    --- ctr-b = \x02, use cmd+b as tmux leader
    { key = "b", mods = "CMD", action = act.SendString("\x02"), },
    --- ctr-d = \x04, exit shell, vim move half page down
    { key = "d", mods = "CMD", action = act.SendString("\x04"), },
    --- ctr-w (window movements, vim, tmux)
    { key = "w", mods = "CMD", action = act.SendString("\x17"), },
    { key = "m", mods = "CMD", action = act.SendString("\x02\x7a") },
    { key = "/", mods = "CMD", action = act.SendString("\x1b\x2f") },
    { key = "g", mods = "CMD", action = act.SendString("\x07") },
    -- {
    --   -- tmux create horizontal pane
    --   key = "u",
    --   mods = "ALT",
    --   action = act.SendString("\x02\x2d"),
    -- },
    -- {
    --   -- tmux create vertical pane
    --   key = "i",
    --   mods = "ALT",
    --   action = act.SendString("\x02\x7c"),
    -- },
  },
  color_schemes                              = {
    -- new or override scheme
    ["Catppuccin Mocha"] = scheme,
  },
  color_scheme                               = 'Catppuccin Mocha',
  font                                       = wezterm.font_with_fallback { 'MonoLisa Liga',
    -- font                                       = wezterm.font_with_fallback { 'MesloLGS NF',
    'Fira Code Nerd Font',
    'Apple Symbols', 'Arial Unicode MS', 'MesloLGS NF' },
  font_rules                                 = {
    {
      -- intensity = 'Bold',
      italic = true,
      font = wezterm.font("MonoLisa Liga", { stretch = "Normal", style = "Italic" })
    },
  },
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation                  = "NeverPrompt",
  cursor_blink_rate                          = 0,
  default_cursor_style                       = "BlinkingBlock",
  font_size                                  = 18,
  line_height                                = 1.3,
  initial_rows                               = 40,
  initial_cols                               = 100,
  -- underline_position                         = -8,
  -- underline_thickness                        = 3,
  -- colors                                     = {
  -- },
  -- window_background_image = "/Users/jlima/Documents/1.jpg",
  -- window_background_opacity = 0.90,
  -- window_background_opacity = 0.95,
  -- macos_window_background_blur = 20,
  -- window_decorations                         = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_NS_VISUAL_EFFECT_MATERIAL_BLUR", -- will blurr eventually
  window_decorations                         = "RESIZE",
  hide_tab_bar_if_only_one_tab               = true,
  front_end                                  = "WebGpu",
  webgpu_power_preference                    = "HighPerformance",
  window_padding                             = {
    left = 20,
    right = 20,
    top = 5,
    bottom = 5,
  },
  -- https://wezfurlong.org/wezterm/config/lua/config/term.html
  -- tempfile=$(mktemp) \
  --   && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  --   && tic -x -o ~/.terminfo $tempfile \
  --   && rm $tempfile
  term                                       = "xterm-256color",
}
