local wezterm = require("wezterm")
local act = wezterm.action
-- local colors, metadata = wezterm.color.load_scheme("~/.config/wezterm/theme_ayu.toml")

return {
	default_prog = { "/bin/zsh", "--login" },
	keys = {
		-- use xxd -psd to get hex char sequences
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			-- turn off cmd+m to minimize window from the os
			key = "m",
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
			-- remove word
			key = "Backspace",
			mods = "CTRL",
			action = wezterm.action.SendString("\x17"),
		},
		{
			-- remove line
			key = "Backspace",
			mods = "ALT",
			action = wezterm.action.SendString("\x17"),
		},
		{
			-- remove line
			key = "Backspace",
			mods = "CMD",
			action = wezterm.action.SendString("\x15"),
		},
		{
			-- https://www.youtube.com/watch?v=BLp61-Lq0kQ
			-- tmux next-window
			key = "]",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x6e"),
		},
		{
			-- tmux previous-window
			key = "[",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x70"),
		},
		{
			-- tmux rename window
			key = "n",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x2c"),
		},
		{
			-- tmux zoom pane
			key = "m",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x7a"),
		},
		{
			-- tmux create horizontal pane
			key = "u",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x2d"),
		},
		{
			-- tmux create vertical pane
			key = "i",
			mods = "CMD",
			action = wezterm.action.SendString("\x02\x7c"),
		},
	},
	-- color_scheme = "theme_numetal", -- 1st pick
	front_end = "WebGpu",
	-- color_scheme = "Catppuccin Frappe",
	-- color_scheme = "Catppuccin Macchiato",
	-- color_scheme = "Catppuccin Mocha",
	-- color_scheme = "Tokyo Night Storm (Gogh)",
	color_scheme = "tokyonight_storm",
	font = wezterm.font({ family = "MonoLisa Liga" }),
	cursor_blink_rate = 350,
	-- default_cursor_style = "BlinkingBlock",
	-- freetype_load_target = 'Light',
	-- freetype_render_target = 'HorizontalLcd',
	-- color_scheme = "_bash (Gogh)" -- 4.11.3 b ( colors not working correctly )
	font_size = 18,
	line_height = 1.4,
	underline_position = -8,
	underline_thickness = 3, -- ()
	colors = {
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
	window_background_opacity = 1.0,
	-- window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_NS_VISUAL_EFFECT_MATERIAL_BLUR", -- will blurr eventually
	window_decorations = "RESIZE",
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
