local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Modus-Operandi'

-- config.enable_tab_bar = false
config.font = wezterm.font 'HackGen Console NF'
-- config.treat_east_asian_ambiguous_width_as_wide = true

local act = wezterm.action

-- キーバインドの初期化
config.keys = config.keys or {}

-- Ctrl+Shift+1〜8：指定のタブへ移動
for i = 1, 8 do
    table.insert(config.keys, {
                     key = 'phys:' .. i,
                     mods = 'CTRL|SHIFT',
                     action = act.ActivateTab(i - 1),
    })
end

-- Ctrl+Shift+9：最後のタブへ移動
table.insert(config.keys, {
                 key = 'phys:9',
                 mods = 'CTRL|SHIFT',
                 action = act.ActivateTab(-1),
})

config.font_size = 11

return config
