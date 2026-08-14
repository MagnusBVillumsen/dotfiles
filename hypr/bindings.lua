return function(programs)
    local mod = "SUPER"
    local scripts = os.getenv("HOME") .. "/.config/hypr/scripts/"

    hl.bind(mod .. " + Return", hl.dsp.exec_cmd(programs.terminal), { description = "Åbn terminal" })
    hl.bind(mod .. " + Space", hl.dsp.exec_cmd(programs.menu), { description = "Åbn app-launcher" })
    hl.bind(mod .. " + ALT + Space", hl.dsp.exec_cmd(scripts .. "desktop-menu"), { description = "Åbn systemmenu" })
    hl.bind(mod .. " + CTRL + SHIFT + Space", hl.dsp.exec_cmd(scripts .. "theme-menu"), { description = "Vælg desktoptema" })
    hl.bind(mod .. " + CTRL + Space", hl.dsp.exec_cmd(scripts .. "wallpaper-menu"), { description = "Vælg wallpaper" })
    hl.bind(mod .. " + K", hl.dsp.exec_cmd(scripts .. "keybindings-menu"), { description = "Vis og søg i keybindings" })
    hl.bind(mod .. " + B", hl.dsp.exec_cmd(scripts .. "focus-mode"), { description = "Skjul eller vis Waybar" })
    hl.bind(mod .. " + E", hl.dsp.exec_cmd(programs.file_manager), { description = "Åbn filhåndtering" })
    hl.bind(mod .. " + R", hl.dsp.submap("rog_r"), { description = "Start ROG-sekvens (O, G)" })
    hl.bind(mod .. " + Q", hl.dsp.window.close(), { description = "Luk aktivt vindue" })
    hl.bind(mod .. " + F", hl.dsp.window.fullscreen(), { description = "Fuld skærm til/fra" })
    hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Flydende vindue til/fra" })
    hl.bind(mod .. " + M", hl.dsp.window.move({ workspace = "special:minimized" }), { description = "Minimér aktivt vindue" })
    hl.bind(mod .. " + ALT + M", hl.dsp.workspace.toggle_special("minimized"), { description = "Vis/skjul minimerede vinduer" })
    hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lås skærmen" })
    hl.bind(mod .. " + SHIFT + M", hl.dsp.exit(), { description = "Afslut Hyprland" })

    hl.bind(mod .. " + C", hl.dsp.exec_cmd('cliphist list | fuzzel --dmenu --prompt "Clipboard> " | cliphist decode | wl-copy'), { description = "Søg i clipboard-historik" })
    hl.bind("Print", hl.dsp.exec_cmd(scripts .. "screenshot area"), { description = "Gem og kopiér valgt skærmområde" })
    hl.bind("SHIFT + Print", hl.dsp.exec_cmd(scripts .. "screenshot screen"), { description = "Gem og kopiér hele skærmen" })

    hl.define_submap("rog_r", function()
        hl.bind("O", hl.dsp.submap("rog_ro"))
        hl.bind("Escape", hl.dsp.submap("reset"))
    end)

    hl.define_submap("rog_ro", function()
        hl.bind("G", function()
            hl.dispatch(hl.dsp.exec_cmd("z13gui"))
            hl.dispatch(hl.dsp.submap("reset"))
        end)
        hl.bind("Escape", hl.dsp.submap("rog_r"))
    end)

    local directions = {
        H = "left",
        J = "down",
        K = "up",
        L = "right",
    }
    for key, direction in pairs(directions) do
        hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = direction }), { description = "Fokusér vindue " .. direction })
        hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }), { description = "Flyt vindue " .. direction })
    end

    for workspace = 1, 9 do
        local key = tostring(workspace)
        hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }), { description = "Skift til workspace " .. key })
        hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }), { description = "Flyt vindue til workspace " .. key })
    end

    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
end
