local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.font = wezterm.font 'HackGen'
config.treat_east_asian_ambiguous_width_as_wide = true

return config
