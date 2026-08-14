hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.window_rule({
    name = "float-polkit",
    match = { class = "^(org\\.hyprland\\.PolicyKit1)$" },
    float = true,
    center = true,
})
