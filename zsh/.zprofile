# Gør bruger-binaries tilgængelige for Hyprland og alt det spawner
# (kører før .zshrc, så PATH skal sættes her).
export PATH="$HOME/.local/bin:$PATH"

# Start the configured Wayland desktop when logging in on a real TTY.
# Display managers and terminals are left alone.
if [[ -z ${WAYLAND_DISPLAY:-} && -z ${DISPLAY:-} && -z ${HYPRLAND_INSTANCE_SIGNATURE:-} ]]; then
    if [[ "$(tty 2>/dev/null)" == /dev/tty* ]]; then
        exec start-hyprland
    fi
fi
