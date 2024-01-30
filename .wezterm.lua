local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrains Mono'
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

return config
