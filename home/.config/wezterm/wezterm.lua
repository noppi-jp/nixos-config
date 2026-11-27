local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Modus-Operandi'

-- config.enable_tab_bar = false
config.font = wezterm.font 'HackGen Console NF'
-- config.treat_east_asian_ambiguous_width_as_wide = true
config.font_size = 11

return config
