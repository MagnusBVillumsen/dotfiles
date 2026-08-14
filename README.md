# Dotfiles

Personlige konfigurationer til Arch Linux. Repoet indeholder konfiguration til
Zsh, Starship, tmux, Neovim, Alacritty, Pi og et modulært Hyprland-miljø til
ASUS ROG Flow Z13.

Desktoplaget er Omarchy-inspireret, men bevidst ikke en Omarchy-installation:
workflow, discoverability og visuel sammenhæng genbruges uden at installere
Claude Code eller andre konto- og appvalg. Se [desktopprofilen](docs/desktop.md).

Kommandoerne herunder er bevidst manuelle. De gør det synligt, hvilke pakker og
links der bliver oprettet, og de overskriver ikke eksisterende konfiguration.

Den samlede, konfliktsikre arbejdsgang er:

```sh
~/dotfiles/bin/dotfiles-check
~/dotfiles/bin/dotfiles-install --check
# Først når konfigurationen er klar til aktivering:
~/dotfiles/bin/dotfiles-install --install
~/dotfiles/bin/dotfiles-install --link
~/dotfiles/bin/dotfiles-install --activate
```

Kommandoerne kan til sidst køres samlet med `dotfiles-install --setup`.
`--check` og `dotfiles-check` ændrer ikke systemet. `--link` accepterer korrekte
eksisterende links, men stopper ved filer, mapper eller links med et andet mål.
Det forbereder samtidig standardtemaet `tokyo-night`; det genindlæser ikke en
kørende session, før `theme-set tokyo-night --apply` køres eksplicit.

På en Flow Z13 køres hardwarelaget separat, fordi det installerer verificerede
release-binaries og opretter systemrettigheder til fans, TDP og batterigrænse:

```sh
~/dotfiles/bin/dotfiles-install --z13
```

## Pakker

Installer de almindelige afhængigheder fra Archs officielle repositories:

```sh
sudo pacman -S --needed \
  alacritty bat base-devel fd fzf git neovim nodejs npm ripgrep \
  starship tmux ttf-jetbrains-mono-nerd unzip wl-clipboard zsh \
  zsh-autosuggestions zsh-syntax-highlighting
```

`base-devel` leverer blandt andet `make` og en C/C++-compiler, som Neovims
plugins bruger under installation.

Installer kun de toolchains, der faktisk skal bruges:

```sh
# Deno
sudo pacman -S --needed deno

# C og CMake
sudo pacman -S --needed clang cmake

# Go
sudo pacman -S --needed go

# Python
sudo pacman -S --needed python-pipx

# Rust
sudo pacman -S --needed rustup

# LaTeX/VimTeX
sudo pacman -S --needed texlive-basic texlive-bin texlive-binextra
```

Neovims Mason-konfiguration installerer de konfigurerede language servers og
`stylua`, når Neovim startes. `nodejs` og `npm` er med i basislisten, fordi den
nuværende Neovim- og Pi-konfiguration bruger JavaScript/TypeScript-værktøjer.

### Hyprland

Installer compositorlaget fra Archs officielle repositories:

```sh
sudo pacman -S --needed \
  brightnessctl cliphist fuzzel grim hypridle hyprland hyprlock hyprpaper \
  hyprpolkitagent iio-sensor-proxy libnotify mako network-manager-applet \
  playerctl power-profiles-daemon python-gobject qt6-wayland slurp \
  waybar xdg-desktop-portal-gtk xdg-desktop-portal-hyprland \
  wl-clipboard
```

`hyprpaper` er konfigureret, men startes først automatisk, når der er valgt et
repo-ejet wallpaper. `swappy`, Howdy, automatisk rotation og skærmtastatur er
bevidst ikke en del af basislaget.

Flow Z13-hostfilen bruger den verificerede interne skærmprofil
`2560x1600@180` med scale 1. Andre maskiner skal have deres eget Lua-modul under
`hypr/hosts/`; fælles input, udseende og bindings skal ikke indeholde
maskinspecifik hardware.

### Valgfrie desktopprogrammer

Desktopprogrammer er ikke dependencies for Hyprland. Installer kun dem, der
skal bruges, for eksempel:

```sh
sudo pacman -S --needed dolphin firefox
```

Alacritty er standardterminal, og Dolphin er standardfilhåndtering i de
nuværende bindings. Programmer som Obsidian, Brave, Discord, Clockify, Steam,
Postman og LocalSend installeres og dokumenteres separat efter behov.

## Klon repoet

Brug HTTPS på en ny maskine, hvor GitHub SSH endnu ikke er konfigureret:

```sh
git clone https://github.com/MagnusBVillumsen/dotfiles.git ~/dotfiles
```

Brug SSH, hvis maskinens SSH-nøgle allerede er tilføjet til GitHub:

```sh
git clone git@github.com:MagnusBVillumsen/dotfiles.git ~/dotfiles
```

Et repo, der er klonet med HTTPS, kan senere skifte til SSH:

```sh
cd ~/dotfiles
git remote set-url origin git@github.com:MagnusBVillumsen/dotfiles.git
```

## Kontroller eksisterende konfiguration

Før links oprettes, bør eksisterende filer og mapper kontrolleres:

```sh
ls -ld \
  ~/.zshrc \
  ~/.config/alacritty \
  ~/.config/fuzzel \
  ~/.config/hypr \
  ~/.config/hyprpaper \
  ~/.config/mako \
  ~/.config/nvim \
  ~/.config/starship.toml \
  ~/.config/tmux \
  ~/.config/waybar \
  ~/.pi/agent/AGENTS.md \
  ~/.pi/agent/extensions/pi-permission-system/config.json \
  ~/.pi/agent/models.json \
  ~/.pi/agent/settings.json \
  ~/.pi/agent/skills/pdf-noter/SKILL.md 2>/dev/null
```

Flyt manuelt eventuelle eksisterende konfigurationer, der skal bevares. Brug
ikke `ln -sf`, da det kan skjule konflikter eller overskrive eksisterende
konfiguration.

## Opret links

Opret først de nødvendige mapper:

```sh
mkdir -p \
  ~/.config/alacritty \
  ~/.config/tmux \
  ~/.pi/agent/extensions/pi-permission-system \
  ~/.pi/agent/skills/pdf-noter
```

Opret derefter links enkeltvis:

```sh
ln -sT ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sT ~/dotfiles/nvim ~/.config/nvim
ln -sT ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sT ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sT ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf

ln -sT ~/dotfiles/hypr ~/.config/hypr
ln -sT ~/dotfiles/waybar ~/.config/waybar
ln -sT ~/dotfiles/fuzzel ~/.config/fuzzel
ln -sT ~/dotfiles/mako ~/.config/mako
ln -sT ~/dotfiles/hyprpaper ~/.config/hyprpaper

ln -sT ~/dotfiles/pi/AGENTS.md ~/.pi/agent/AGENTS.md
ln -sT ~/dotfiles/pi/settings.json ~/.pi/agent/settings.json
ln -sT ~/dotfiles/pi/models.json ~/.pi/agent/models.json
ln -sT \
  ~/dotfiles/pi/extensions/pi-permission-system/config.json \
  ~/.pi/agent/extensions/pi-permission-system/config.json
ln -sT \
  ~/dotfiles/pi/skills/pdf-noter/SKILL.md \
  ~/.pi/agent/skills/pdf-noter/SKILL.md
```

`-s` opretter et symbolsk link, og `-T` forhindrer, at linket utilsigtet bliver
placeret inde i en eksisterende mappe. Kommandoen skal fejle, hvis destinationen
allerede findes. Undersøg destinationen i stedet for at gennemtvinge en
overskrivning.

En førstegangsstart af Hyprland kan have oprettet en autogenereret
`~/.config/hypr/hyprland.lua`. Flyt i så fald hele `~/.config/hypr` til et
selvvalgt backupnavn, før directory-linket oprettes. Repoets entrypoint bruger
Hyprland 0.56's Lua-format og loader de fælles moduler med `require`. Log normalt
ud og ind efter linket er oprettet; en kørende legacy-session kan ikke skifte
parser ved reload.

På en TTY startes sessionen med Lua-entrypointet eksplicit:

```sh
start-hyprland -- --config ~/.config/hypr/hyprland.lua
```

Repoets Zsh-konfiguration har et alias, så den korte kommando
`start-hyprland` udfører netop dette. Det er nødvendigt med Hyprland 0.56,
fordi en start uden `--config` ellers opretter og bruger en legacy
`hyprland.conf`-stub.

Efter `dotfiles-install --link` starter `.zprofile` automatisk Hyprland ved
TTY-login. Display managers og terminaler inde i en allerede kørende session
bliver ikke påvirket.

## Hyprland-genveje

De vigtigste genveje er:

| Genvej | Handling |
| --- | --- |
| `Super+Return` | Alacritty |
| `Super+R`, `O`, `G` | Åbn/skjul Z13 Controls |
| `Super+Space` | Fuzzel |
| `Super+K` | Søgbar oversigt over alle beskrevne keybindings |
| `Super+Alt+Space` | Systemmenu med lås, suspend, logout og strømvalg |
| `Super+Ctrl+Shift+Space` | Vælg og anvend desktoptema |
| `Super+Ctrl+Space` | Vælg repo-ejet wallpaper |
| `Super+B` | Toggle focus mode (skjul/vis Waybar) |
| `Super+E` | Dolphin |
| `Super+C` | Clipboard-historik |
| `Super+Q` | Luk aktivt vindue |
| `Super+Shift+L` | Lås med Hyprlock |
| `Print` | Gem og kopiér screenshot af valgt område |
| `Shift+Print` | Gem og kopiér screenshot af hele skærmen |

Kommandoen `focus-mode` kan også køres direkte i en terminal. Den sender
Waybars egen visibility-toggle og bevarer processen og dens tilstand.

Hyprlock bruger password/PAM som baseline. Tilføj ikke Howdy til PAM, før
IR-kamera, afviste ansigter, tildækket kamera og password-fallback er testet.

## Flow Z13-status

Følgende er valideret på ASUS ROG Flow Z13 2025 (GZ302EA):

- Det interne panel kører native `2560x1600@180` med scale 1 og sRGB. Scale 1
  gav tydeligt skarpere tekst end 1,25 og 2 på det fysiske panel; programmernes
  fonts og kontrolflader er gjort større individuelt.
- Touchscreen og ELAN9008-stylus registreres af kernel og Hyprland.
- Password-baseret Hyprlock virker.
- Suspend/resume via `s2idle` virker med standardkernel; AMDGPU, NVMe og
  180 Hz-panelet kom tilbage uden fejl i den testede cyklus.
- `power-profiles-daemon` skifter mellem performance, balanced og power-saver;
  standarden er fortsat balanced.
- Waybar, Mako, polkit, clipboard-historik og screenshots virker.
- Det dedikerede IR-kamera findes på `/dev/video2` som 640x360 GREY ved 15
  fps. Det gør et senere Howdy-eksperiment realistisk, men PAM er ikke ændret.
- Begge USB4-domæner og to Type-C-porte registreres; ekstern skærm/dock er
  endnu ikke fysisk testet.
- Batteriets rapporterede fulde kapacitet svarer omtrent til designkapaciteten,
  og UPower rapporterer et ASUS-ladevindue på 75-80 procent.

Automatisk rotation bruger ITE8353-accelerometeret via `iio-sensor-proxy`.
Handleren roterer det interne panel samt touch- og stylus-koordinater og starter
sammen med Hyprland. `normal`, `left-up` og `right-up` er fysisk valideret.
Touch og pen rammer korrekt efter rotation, og testen bestod med det aftagelige
tastatur afmonteret.
Rear Window Lighting er ikke eksponeret som en almindelig sysfs LED og må
derfor styres gennem `z13ctl`. Den fulde opsætning bruges, så Z13 Controls også
kan ændre platformprofil, fan curves, TDP/PPT og batteriets ladegrænse uden at
køre GUI'en som root. Det betyder, at medlemmer af `users`-gruppen får
skriveadgang til de relevante ASUS-platformattributter. Undervolting og
`ryzen_smu` er fortsat bevidst ikke installeret.

Installer de grafiske afhængigheder og den checksum-verificerede `z13ctl`
release-binary i `~/.local/bin/z13ctl`. Kontrollér derefter ændringerne og kør
den fulde systemopsætning:

```sh
sudo pacman -S --needed gtk4 gtk4-layer-shell
z13ctl --dry-run setup
sudo z13ctl setup
```

Hvis den tidligere, begrænsede RGB-regel findes, fjernes den først efter at
`z13ctl setup` har oprettet `/etc/udev/rules.d/99-z13ctl.rules`:

```sh
sudo rm /etc/udev/rules.d/99-z13ctl-lighting.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Log ud og ind, hvis `z13ctl setup` netop har føjet brugeren til `users`-gruppen.
Hyprland starter `z13ctl daemon` direkte, så fan-kurven frigives sikkert før
suspend og gendannes efter resume. Waybars Z13-modul viser den aktuelle profil
og temperatur; et klik starter eller skjuler den touchvenlige GUI. Hyprland-
autostart slukker fortsat Rear Window Lighting uden at ændre fan- eller
effektindstillinger.

Alacritty er verificeret som native Wayland, og compositor-screenshots er native
2560x1600. Scale 1 var visuelt skarpere end både 1,25 og 2, så skalering sker
ikke længere i compositoren. 180 Hz er bevaret, og ASUS' `panel_od` er
verificeret som deaktiveret.

## Btrfs-snapshots

Den installerede Btrfs-struktur har allerede separate subvolumes for root
(`@`), home (`@home`), logs (`@log`) og pacman-cache (`@pkg`). Den valgte retning
er Snapper kun for root; `/home` skal ikke have automatiske snapshots.

Før store lokale modeller downloades, skal de placeres på et separat
`@models`-subvolume. Snapper-filtre udelader ikke data fra selve snapshotet, så
et separat subvolume er den korrekte grænse. De cirka 100 GiB frie LVM-extents
skal fortsat ikke ændres.

Maskinen booter med systemd-boot og en UKI på EFI-partitionen. Installer ikke
GRUB-specifik snapshot-integration. Dokumentér og test først manuel recovery
fra Arch-ISO, og aktivér derefter Snapper med begrænset number-cleanup. Btrfs-
snapshots på samme SSD er recovery-punkter, ikke backup.

## tmux-plugins

`dotfiles-install --setup` kloner TPM konfliktsikkert og installerer de
konfigurerede plugins. Trinnet kan også køres separat og gentages sikkert:

```sh
~/dotfiles/bin/dotfiles-install --plugins
```

## Shell

Skift login-shell til Zsh:

```sh
chsh -s /usr/bin/zsh
```

Log ud og ind igen, før ændringen forventes at være aktiv overalt.

## Autentificering

Log ind i Pi og Codex manuelt på hver maskine. Loginfilerne må ikke linkes eller
gemmes i repoet:

```text
~/.pi/agent/auth.json
~/.codex/auth.json
```

Begge filer skal forblive lokale og kun være læsbare for brugeren.

## Kontrol

Kontroller links efter installationen:

```sh
readlink -f ~/.zshrc
readlink -f ~/.config/nvim
readlink -f ~/.config/alacritty/alacritty.toml
readlink -f ~/.config/starship.toml
readlink -f ~/.config/tmux/tmux.conf
readlink -f ~/.config/hypr
readlink -f ~/.config/waybar
readlink -f ~/.config/fuzzel
readlink -f ~/.config/mako
readlink -f ~/.config/hyprpaper
readlink -f ~/.pi/agent/AGENTS.md
readlink -f ~/.pi/agent/models.json
readlink -f ~/.pi/agent/settings.json
readlink -f ~/.pi/agent/extensions/pi-permission-system/config.json
readlink -f ~/.pi/agent/skills/pdf-noter/SKILL.md
```
