local wezterm = require('wezterm')
local home = os.getenv("HOME")
local wallpaper_path = string.gsub("~/Documents/anime/mythra.png", "~", "")

return {
    audible_bell = 'Disabled',
    max_fps = 120,

    hide_tab_bar_if_only_one_tab = true,
    background = {
        {
            source = {File = home .. wallpaper_path},
            repeat_x = "NoRepeat",
            hsb = {brightness = 0.03}
        }
    },
    window_background_opacity = 0.85,
    text_background_opacity = 0.90,
    window_decorations = "RESIZE",

    color_scheme = 'Tomorrow Night Bright',
    font = wezterm.font {family = 'JetbrainsMono Nerd Font Mono', weight = 'Medium'},
    font_size = 15
}
