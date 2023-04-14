local wezterm = require("wezterm")

return {
  -- default_prog = { "wsl.exe" },
  -- default_cwd = "C:\\Users\\A270581\\Desktop\\work",
  default_domain = 'WSL:Ubuntu', -- wsl -l -v
  default_cwd = wezterm.homedir,
  audible_bell = "Disabled",
  pane_focus_follows_mouse = true,
  use_dead_keys = false,
  unicode_version  = 14,
  keys = {
    -- use xxd -psd to get hex char sequences
    {
      key = "w",
      mods = "ALT",
      action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
      -- turn off alt+m to minimize window from the os
      key = "m",
      mods = "ALT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "i",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "q",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action.CopyTo("Clipboard"),
    },
    {
      -- delete word
      key = "Backspace",
      mods = "CTRL",
      action = wezterm.action.SendString("\x17"),
    },
    {
      -- delet line
      key = "Backspace",
      mods = "ALT",
      action = wezterm.action.SendString("\x15"),
    },
    {
      -- https://www.youtube.com/watch?v=BLp61-Lq0kQ
      -- tmux next-window
      key = "]",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x6e"),
    },
    {
      -- tmux previous-window
      key = "[",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x70"),
    },
    {
      -- tmux rename window
      key = "n",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x2c"),
    },
    {
      -- tmux zoom pane
      key = "m",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x7a"),
    },
    {
      -- tmux create horizontal pane
      key = "u",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x2d"),
    },
    {
      -- tmux create vertical pane
      key = "i",
      mods = "ALT",
      action = wezterm.action.SendString("\x02\x7c"),
    },
  },
  -- color_scheme = "theme_numetal", -- 1st pick
  -- front_end = "WebGpu",
  color_scheme = "tokyonight_storm",
  font = wezterm.font({ family = "MonoLisa Liga" }),
  -- freetype_load_target = "HorizontalLcd",
  -- front_end = "OpenGL",
  cursor_blink_rate = 350,
  font_size = 12,
  line_height = 1.4,
  -- dpi = 110,
  underline_position = -8,
  underline_thickness = 3, -- ()
  colors = {
  },
  adjust_window_size_when_changing_font_size = false,
  -- window_background_opacity = 0.95,
  -- macos_window_background_blur = 20,
  -- window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
  -- https://wezfurlong.org/wezterm/config/lua/config/term.html
  -- tempfile=$(mktemp) \
  --   && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  --   && tic -x -o ~/.terminfo $tempfile \
  --   && rm $tempfile
  -- term = "wezterm",
}
