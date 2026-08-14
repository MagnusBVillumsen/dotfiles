# Desktopprofil

Dette repo bygger et let KDE Plasma-miljø oven på en normal Arch-installation.
Konfigurationen er bevidst ikke en Omarchy-installation: workflow og visuel
sammenhæng genbruges, men uden at tvinge Claude Code eller andre appvalg ind.

## Med i basislaget

- KDE Plasma som desktop med SDDM som display manager.
- Zsh, Starship, tmux, Neovim, Alacritty og Fuzzel.
- Et samlet temalag (`tokyo-night`) til Alacritty, Fuzzel og tmux.
- GTK dark-mode og Breeze-integration via repo-ejede `gtk/*/settings.ini`.
- Eksplicitte XDG-standardapps via `xdg/mimeapps.list`.
- Reproducerbare pakkemanifester og konfliktsikre symlinks.
- Hardware-laget `z13ctl` til ASUS ROG Flow Z13.

## Bevidst ikke tvunget ind

- Claude Code eller en anden bestemt AI-klient.
- HEY, 1Password, Spotify, Signal, WhatsApp eller andre konto-bundne apps.
- En bestemt browser ud over en simpel Firefox-baseline.
- Docker, Steam, Obsidian, LocalSend eller toolchains, der ikke bruges.
- Undervolting, ansigts-PAM eller andre hardware-/sikkerhedsændringer som standard.

Valgfrie programmer står kommenteret i `packages/optional.txt`. Et program
bliver først en del af installationen, når det bevidst flyttes til et aktivt
manifest eller installeres separat.

## Arbejdsgang

1. Redigér dotfiles og manifester.
2. Kør `bin/dotfiles-install --check` uden systemændringer.
3. Kør `bin/dotfiles-check` for shellscripts og whitespace.
4. Kør samlet pakkeinstallation og linkning.
5. Aktivér temaet.
6. Finjustér fonts, spacing og farver.

Når alt er godkendt, udfører `bin/dotfiles-install --setup` pakkeinstallation,
konfliktsikker linkning og aktivering i den rækkefølge. Trinnene findes
fortsat separat, så en konflikt kan undersøges uden at resten gennemtvinges.

## Temaer og wallpapers

Et tema er en mappe under `themes/` med app-fragmenter til Alacritty, Fuzzel
og tmux. `bin/theme-set THEME` kopierer dem til runtime-laget
`~/.config/dotfiles-theme`; `--apply` genindlæser tmux. Repoets standard er
`tokyo-night`.

KDE's egne temaer, wallpapers og plasmoider styres i Systemindstillinger og
er ikke repo-ejede.
