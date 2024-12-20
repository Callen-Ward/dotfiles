local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font('FiraCode Nerd Font Mono', { weight = 500 })
config.font_size = 12.0
config.adjust_window_size_when_changing_font_size = false
config.bold_brightens_ansi_colors = false

config.default_cursor_style = 'SteadyUnderline'
config.cursor_thickness = '1pt'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

config.animation_fps = 120

config.check_for_updates = false

config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = true

local act = wezterm.action
config.keys = {
    { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },

    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SUPER',      action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SUPER',      action = act.PasteFrom 'Clipboard' },

    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = 'n', mods = 'SUPER',      action = act.SpawnWindow },
}

-- only starts on hyprland when a window is already focused, run through xwayland instead
config.enable_wayland = false

return config
