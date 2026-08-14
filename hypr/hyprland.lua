-- Modulært entrypoint til Hyprland 0.56+.
local programs = {
    terminal = "alacritty",
    file_manager = "dolphin",
    menu = "fuzzel",
}

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")

require("appearance")
require("input")
require("windows")
require("monitors")
require("bindings")(programs)
require("autostart")
require("hosts.flow_z13")
