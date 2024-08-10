local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' })
config.font_size = 13

config.color_scheme = 'Blue Matrix'

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_background_opacity = 0.8

return config
