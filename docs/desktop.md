# Desktopprofil

Dette repo bygger et let, Omarchy-inspireret Hyprland-miljø oven på en normal
Arch-installation. Omarchy er inspiration til workflow og discoverability, ikke
en dependency eller en pakkeprofil, der overtager systemet.

## Med i basislaget

- Modulær Hyprland 0.56+ Lua-konfiguration.
- Fuzzel som app-launcher og dmenu-frontend.
- En søgbar keybinding-oversigt på `Super+K` og i Waybar.
- En systemmenu på `Super+Alt+Space` og i Waybar.
- Et samlet temalag på `Super+Ctrl+Shift+Space`, der synkroniserer Hyprland,
  wallpaper, Alacritty, Waybar, Fuzzel, Mako og Hyprlock.
- Waybar, Mako, Hyprlock, Hypridle, clipboard-historik og screenshots.
- Vim-lignende vinduesnavigation med `Super+H/J/K/L`.
- Hostmoduler til maskinspecifik skærm-, touch- og rotationsopsætning.
- Reproducerbare pakkemanifester og konfliktsikre symlinks.
- GTK dark-mode, Wayland-native appmiljø og eksplicitte XDG-standardapps.

## Bevidst ikke tvunget ind

- Claude Code eller en anden bestemt AI-klient.
- HEY, 1Password, Spotify, Signal, WhatsApp eller andre konto-bundne apps.
- En bestemt browser ud over en enkel Firefox-baseline.
- Docker, Steam, Obsidian, LocalSend eller udviklings-toolchains, som ikke bruges.
- Omarchys update-system, webapp-generator eller egne pakkerepositories.
- Undervolting, ansigts-PAM eller andre sikkerheds-/hardwareændringer som standard.

Valgfrie programmer står kommenteret i `packages/optional.txt`. Et program
bliver først en del af installationen, når det bevidst flyttes til et aktivt
manifest eller installeres separat.

## Arbejdsgang

1. Redigér dotfiles og manifester.
2. Kør `bin/dotfiles-install --check` uden systemændringer.
3. Kør `bin/dotfiles-check` for Lua, JSON, JavaScript og shellscripts.
4. Kør samlet pakkeinstallation og linkning.
5. Aktivér/reload desktoplaget.
6. Finjustér fonts, spacing, farver og hardwareadfærd på den fysiske maskine.

Når alt er godkendt, udfører `bin/dotfiles-install --setup` pakkeinstallation,
konfliktsikker linkning og live-aktivering i den rækkefølge. Trinnene findes
fortsat separat, så en konflikt kan undersøges uden at resten gennemtvinges.

## Temaer og wallpapers

Et tema er en mappe under `themes/` med app-fragmenter til Alacritty, Fuzzel,
Mako, Waybar, Hyprland, Hyprlock, Hyprpaper og tmux. `bin/theme-set THEME` kopierer
dem til det ignorerbare runtime-lag `~/.config/dotfiles-theme`; `--apply`
genindlæser den aktive session. Repoets standard er `tokyo-night`.

`Super+Ctrl+Shift+Space` opdager automatisk alle komplette temamapper.
`Super+Ctrl+Space` opdager PNG, JPEG og WebP-filer under `wallpapers/`. Et
wallpapervalg opdaterer både Hyprpaper og næste Hyprlock-start uden at ændre
tracked configfiler.

Det første wallpaper, `wallpapers/tokyo-night/abstract-planes.png`, er et
repo-ejet 2560x1600-asset lavet specifikt til det interne 16:10-panel. Det har
et roligt, mørkt center, så terminalvinduer og låseskærmens tekst forbliver
læselige.
