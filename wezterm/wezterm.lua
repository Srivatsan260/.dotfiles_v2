local wezterm = require("wezterm")

local function get_background()
    local home = os.getenv("HOME")
    local wallpaper_path = string.gsub("~/Downloads/wallpapers/2758446.jpg", "~", "")
    local opts = {
        {
            source = { File = home .. wallpaper_path },
            repeat_x = "NoRepeat",
            hsb = { brightness = 0.018 },
            vertical_align = "Middle",
        },
    }
    return {}
    -- return opts
end

return {
    audible_bell = "Disabled",
    max_fps = 120,

    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    background = get_background(),
    window_background_opacity = 0.90,
    text_background_opacity = 0.90,
    window_decorations = "RESIZE",

    color_scheme = "Tomorrow Night Bright",
    font = wezterm.font({ family = "JetbrainsMono Nerd Font Mono", weight = "Medium" }),
    font_size = 15,
}
