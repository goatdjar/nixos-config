-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- This is where you actually apply your config choices

-- wezterm.on('update-right-status', function(window, pane)
--   window:set_left_status '<'
--   window:set_right_status '>'
-- end)

-- config.use_fancy_tab_bar = true
-- config.show_tabs_in_tab_bar = true
-- config.show_new_tab_button_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.85

-- Remove all borders
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Remove Window Decorations
config.window_decorations = "NONE"

-- For example, changing the color scheme:
config.color_scheme = 'Gruvbox dark, medium (base16)'

-- config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Medium' })
-- config.font = wezterm.font('0xProto Nerd Font Mono', { weight = 'Regular' })
-- config.font = wezterm.font 'Iosevka Nerd Font'
-- config.font = wezterm.font '0x Proto Nerd Font'
-- config.font = wezterm.font '0xProto Nerd Font Propo'
config.font = wezterm.font 'Iosevka Nerd Font'
config.font_size = 15

-- ToggleAlwaysOnTop
config.keys = {
  { key = ']', mods = 'CMD|SHIFT', action = wezterm.action.ToggleAlwaysOnTop },
  { key = 'R', mods = 'CMD|SHIFT', action = act.RotatePanes 'Clockwise' },
  { key = 'r', mods = 'CMD|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  -- Keyboard bindbings
--   {
--     key = '_',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.SplitVertical
--     {
--     },
--     -- action = wezterm.action.SpawnTab 'CurrentPaneDomain',
--   },
--   {

--     key = '|',
--     mods = 'CTRL|SHIFT|ALT',
--     action = wezterm.action.SplitHorizontal
--     {
--     },
--   },
}

-- StartWindowDrag
config.mouse_bindings = {
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = wezterm.action.StartWindowDrag,
  },
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CTRL|SHIFT',
    action = wezterm.action.StartWindowDrag,
  },
}


-- and finally, return the configuration to wezterm
return config
