local wezterm = require("wezterm")
local act = wezterm.action
-- local colors, metadata = wezterm.color.load_scheme("~/.config/wezterm/theme_ayu.toml")

return {
  default_prog                 = { "/bin/zsh", "--login" },
  audible_bell                 = "Disabled",
  use_dead_keys                = false,
  unicode_version              = 14,
  default_cwd                  = wezterm.homedir,
  keys                         = {
    -- use xxd -psd to get hex char sequences
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
      -- turn off cmd+m to minimize window from the os
      key = "m",
      mods = "CMD",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      -- turn off cmd+m to minimize window from the os
      key = "i",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      -- disable clear scrollback
      key = "k",
      mods = "CMD",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      -- turn off cmd+h to hide window from the os
      key = "h",
      mods = "CMD",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      -- turn off cmd+m to hide window from the os
      key = "q",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "v",
      mods = "CMD",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    -- {
    -- 	-- remove word, to avoid confusion this binding is disabled for now
    -- 	key = "Backspace",
    -- 	mods = "CTRL",
    -- 	action = wezterm.action.SendString("\x17"),
    -- },
    {
      -- delete word
      key = "Backspace",
      mods = "CTRL",
      action = wezterm.action.SendString("\x17"),
    },
    {
      -- delete line
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
  -- front_end                    = "WebGpu",
  -- color_scheme = "theme_numetal", -- 1st pick
  -- color_scheme = "Tokyo Night Storm (Gogh)",
  -- color_scheme = "tokyonight_storm",  -- current best
  -- color_scheme = "Galaxy",
  -- color_scheme                 = 'Harmonic16 Dark (base16)',
  color_scheme                 = 'mine',
  color_schemes                = {
    ['mine'] = {
      -- background = "#222932",
      -- background = "#202933",
      background = "#222932",
      foreground = "#dee6f0",
      cursor_fg = "#323a4c",
      cursor_bg = "#ffffff",
      cursor_border = "#ffcc66",
      selection_bg = "#33415e",
      selection_fg = "#cbccc6",
      ansi = { "#192028", "#e27e8d", "#8ec596", "#fad07b", "#8EAAF4", "#c6a0f6", "#c0f0f0", "#c7c7c7" },
      brights = { "#686868", "#e27e8d", "#8ec596", "#ffd580", "#8EAAF4", "#b7bdf8", "#c0f0f0", "#ffffff", }
    }
  },
  font                         = wezterm.font({ family = "MonoLisa Liga" }),
  -- freetype_load_target = "HorizontalLcd",
  cursor_blink_rate            = 350,
  default_cursor_style         = "BlinkingBlock",
  -- freetype_load_target = 'Light',
  -- freetype_render_target = 'HorizontalLcd',
  font_size                    = 18,
  line_height                  = 1.4,
  underline_position           = -8,
  underline_thickness          = 3, -- ()
  colors                       = {

    -- cursor_bg = "white",
    -- Overrides the text color when the current cell is occupied by the cursor
    -- cursor_fg = "black",
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    -- cursor_border = "#52ad70",
  },
  -- window_background_image = "/Users/jlima/Documents/1.jpg",
  -- window_background_opacity = 0.90,
  -- window_background_opacity = 0.95,
  -- macos_window_background_blur = 20,
  -- window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_NS_VISUAL_EFFECT_MATERIAL_BLUR", -- will blurr eventually
  window_decorations           = "RESIZE",
  hide_tab_bar_if_only_one_tab = true,
  window_padding               = {
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
  term                         = "wezterm",
}
