local wezterm = require('wezterm')

return {
    max_fps = 120,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.87,
    text_background_opacity = 0.87,
    window_decorations = "RESIZE",
    color_scheme = 'Tomorrow Night Bright',
    font = wezterm.font {
        family = 'JetbrainsMono Nerd Font Mono',
        weight = 'Medium'
    },
    font_size = 15
}