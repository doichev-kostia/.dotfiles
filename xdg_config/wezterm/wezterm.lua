local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local theme = require('lua/rose-pine').dawn
config.colors = theme.colors()
config.window_frame = theme.window_frame()

config.font = wezterm.font {
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
config.font_size = 16.0

config.use_fancy_tab_bar = true
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

config.tab_bar_at_bottom = true

-- config.debug_key_events = true

config.keys = {
	{
		key = 'Tab',
		mods = 'CTRL',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'Tab',
		mods = 'SHIFT|CTRL',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'n',
		mods = 'CTRL',
		action = wezterm.action.DisableDefaultAssignment
	},
	{
		key = 'p',
		mods = 'CTRL',
		action = wezterm.action.DisableDefaultAssignment
	}
}

return config
