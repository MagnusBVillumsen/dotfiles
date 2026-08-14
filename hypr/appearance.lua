local home = os.getenv("HOME")
local runtime_theme = home .. "/.config/dotfiles-theme/hypr.lua"
local theme_file = io.open(runtime_theme, "r")
local theme
if theme_file then
    theme_file:close()
    theme = dofile(runtime_theme)
else
    theme = dofile(home .. "/dotfiles/themes/tokyo-night/hypr.lua")
end

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { theme.blue, theme.magenta },
                angle = 45,
            },
            inactive_border = "rgb(414868)",
        },
        resize_on_border = true,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = 0x66000000,
        },
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
        },
    },
    animations = { enabled = true },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})

hl.curve("easeOut", {
    type = "bezier",
    points = { { 0.16, 1 }, { 0.3, 1 } },
})
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOut" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOut", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "easeOut", style = "popin 85%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "easeOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOut", style = "slide" })
