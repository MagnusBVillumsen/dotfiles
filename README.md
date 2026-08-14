# Dotfiles

Personlige konfigurationer til Arch Linux med KDE Plasma. Repoet indeholder
konfiguration til Zsh, Starship, tmux, Neovim, Alacritty, Pi og
hardware-laget til ASUS ROG Flow Z13 (`z13ctl`).

Desktopprofilen er beskrevet i [docs/desktop.md](docs/desktop.md).

Kommandoerne herunder er bevidst manuelle: de viser hvilke pakker og links der
bliver oprettet, og de overskriver ikke eksisterende konfiguration.

Den samlede, konfliktsikre arbejdsgang er:

```sh
~/dotfiles/bin/dotfiles-check
~/dotfiles/bin/dotfiles-install --check
# Først når konfigurationen er klar til aktivering:
~/dotfiles/bin/dotfiles-install --install
~/dotfiles/bin/dotfiles-install --link
~/dotfiles/bin/dotfiles-install --activate
```

`--check` og `dotfiles-check` ændrer ikke systemet. `--link` accepterer
korrekte eksisterende links, men stopper ved filer, mapper eller links med et
andet mål. Det forbereder samtidig standardtemaet `tokyo-night`.

På en Flow Z13 køres hardware-laget separat, fordi det installerer en
verificeret release-binary og opretter systemrettigheder til fans, TDP og
batterigrænse:

```sh
~/dotfiles/bin/dotfiles-install --z13
```

## Pakker

Basisværktøjer fra Archs officielle repositories (se `packages/core.txt`):

```sh
sudo pacman -S --needed \
  alacritty bat base-devel fd fzf git neovim nodejs npm ripgrep \
  starship tmux ttf-jetbrains-mono-nerd unzip wl-clipboard zsh \
  zsh-autosuggestions zsh-syntax-highlighting
```

`base-devel` leverer blandt andet `make` og en C/C++-compiler, som Neovims
plugins bruger under installation.

KDE Plasma installeres som kerne-pakker (plasma-workspace, kwin, sddm mv.),
og `packages/desktop.txt` indeholder de valgte KDE-essentials:

```sh
sudo pacman -S --needed okular gwenview ark filelight kdegraphics-thumbnailers
```

`packages/explicit.txt` er et snapshot af eksplicit installerede pakker
(`pacman -Qqe`). `packages/optional.txt` er valgfri programmer, der først
bliver en del af installationen, når de flyttes til et aktivt manifest.

Installér kun de toolchains, der faktisk skal bruges:

```sh
sudo pacman -S --needed deno          # Deno
sudo pacman -S --needed clang cmake    # C/C++ og CMake
sudo pacman -S --needed go             # Go
sudo pacman -S --needed python-pipx    # Python
sudo pacman -S --needed rustup         # Rust
```

## Klon repoet

Brug SSH, når maskinens nøgle allerede er tilføjet til GitHub:

```sh
git clone git@github.com:MagnusBVillumsen/dotfiles.git ~/dotfiles
```

Brug HTTPS på en ny maskine, hvor SSH endnu ikke er konfigureret:

```sh
git clone https://github.com/MagnusBVillumsen/dotfiles.git ~/dotfiles
```

Et HTTPS-klonet repo kan senere skifte til SSH:

```sh
cd ~/dotfiles
git remote set-url origin git@github.com:MagnusBVillumsen/dotfiles.git
```

## Opret links

`dotfiles-install --link` opretter symlinks konfliktsikkert med `ln -s` og `-T`
(for at undgå utilsigtede placeringer inde i eksisterende mapper). Kommandoen
fejler ved konflikter i stedet for at gennemtvinge en overskrivning.

De vigtigste links er:

```sh
ln -sT ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sT ~/dotfiles/zsh/.zprofile ~/.zprofile
ln -sT ~/dotfiles/nvim ~/.config/nvim
ln -sT ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sT ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sT ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sT ~/dotfiles/gtk/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
ln -sT ~/dotfiles/gtk/gtk-4.0/settings.ini ~/.config/gtk-4.0/settings.ini
ln -sT ~/dotfiles/xdg/mimeapps.list ~/.config/mimeapps.list
```

Pi-konfiguration og z13-systemd-units linkes også — se `bin/dotfiles-install`
for den fulde liste.

## KDE Plasma

- Desktop-laget er KDE Plasma med SDDM som display manager.
- Wayland-sessionen findes i SDDM (`Plasma (Wayland)`); skift til Wayland kræver
  logout. Den nuværende session kører X11.
- GTK-apps bruger Breeze-tema, -icons og -cursors via de repo-ejede
  `gtk/*/settings.ini`, som KDE synkroniserer gennem `kde-gtk-config`.
- Plasma-tema, wallpapers, plasmoider og panels styres i KDE's egne
  indstillinger (Systemindstillinger) og er ikke repo-ejede.

## Temaer

Et tema er en mappe under `themes/` med app-fragmenter til Alacritty og tmux. `bin/theme-set THEME` kopierer dem til det ignorerbare runtime-lag
`~/.config/dotfiles-theme`; `--apply` genindlæser tmux. Repoets standard er
`tokyo-night`.

## Flow Z13

`z13ctl` styrer platformprofil, fan curves, TDP/PPT og batteriets ladegrænse
på ASUS ROG Flow Z13. Det kører som en user-systemd-service og har en
touchvenlig GUI (`z13gui`). Installér med:

```sh
~/dotfiles/bin/dotfiles-install --z13
```

## tmux-plugins

`dotfiles-install --setup` kloner TPM konfliktsikkert og installerer de
konfigurerede plugins. Trinnet kan køres separat og gentages sikkert:

```sh
~/dotfiles/bin/dotfiles-install --plugins
```

## Shell

Skift login-shell til Zsh:

```sh
chsh -s /usr/bin/zsh
```

## Autentificering

Log ind i Pi og Codex manuelt på hver maskine. Loginfilerne må ikke linkes
eller gemmes i repoet:

```text
~/.pi/agent/auth.json
~/.codex/auth.json
```

Begge filer skal forblive lokale og kun være læsbare for brugeren.

## Kontrol

Kontrollér links og scripts efter ændringer:

```sh
~/dotfiles/bin/dotfiles-check
```

`dotfiles-check` validerer shell-syntaks og whitespace. Kør det efter hver
config-ændring.
