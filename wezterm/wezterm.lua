local wezterm = require("wezterm")
local act = wezterm.action
-- local colors, metadata = wezterm.color.load_scheme("~/.config/wezterm/theme_ayu.toml")

return {
  default_prog                               = { "/bin/zsh", "--login" },
  audible_bell                               = "Disabled",
  use_dead_keys                              = false,
  unicode_version                            = 14,
  default_cwd                                = wezterm.homedir,
  enable_csi_u_key_encoding                  = true,
  keys                                       = {
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
  color_scheme                               = "Catppuccin Mocha",
  -- color_scheme                 = 'mine',
  -- color_schemes                = {
  --   ['mine'] = {
  --     -- background = "#222932",
  --     background = "#202933",
  --     -- foreground = "#dee6f0",
  --     foreground = "#c7cff7",
  --     cursor_fg = "#323a4c",
  --     cursor_bg = "#ffffff",
  --     cursor_border = "#ffcc66",
  --     selection_bg = "#33415e",
  --     selection_fg = "#cbccc6",
  --     ansi = { "#192028", "#e27e8d", "#c5dea1", "#c49a5a", "#8EAAF4", "#c6a0f6", "#5ec4ff", "#c7c7c7" },
  --     brights = { "#686868", "#e27e8d", "#b6d68a", "#ffd580", "#8EAAF4", "#b7bdf8", "#70e1e8", "#ffffff", }
  --   }
  -- },
  font                                       = wezterm.font({ family = "MonoLisa Liga" }),
  font_rules                                 = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font("MonoLisa Liga", { weight = "Bold", stretch = "Normal", style = "Normal" })
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font("MonoLisa Liga", { weight = "Bold", stretch = "Normal", style = "Italic" })
    },
  },
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation                  = "NeverPrompt",
  cursor_blink_rate                          = 350,
  default_cursor_style                       = "BlinkingBlock",
  font_size                                  = 18,
  line_height                                = 1.4,
  underline_position                         = -8,
  underline_thickness                        = 3, -- ()
  colors                                     = {
  },
  -- window_background_image = "/Users/jlima/Documents/1.jpg",
  -- window_background_opacity = 0.90,
  -- window_background_opacity = 0.95,
  -- macos_window_background_blur = 20,
  -- window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_NS_VISUAL_EFFECT_MATERIAL_BLUR", -- will blurr eventually
  window_decorations                         = "RESIZE",
  hide_tab_bar_if_only_one_tab               = true,
  window_padding                             = {
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
  term                                       = "wezterm",
}
