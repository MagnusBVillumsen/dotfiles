# Dotfiles

Personlige konfigurationer til Arch Linux. Repoet indeholder konfiguration til
Zsh, Starship, tmux, Neovim, Alacritty og Pi.

Kommandoerne herunder er bevidst manuelle. De gør det synligt, hvilke pakker og
links der bliver oprettet, og de overskriver ikke eksisterende konfiguration.

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

Hyprland-, Plasma- og Flow Z13-afhængigheder dokumenteres separat, når disse
konfigurationer bliver tilføjet til repoet.

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
  ~/.config/nvim \
  ~/.config/starship.toml \
  ~/.config/tmux \
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

## tmux-plugins

Installer TPM efter tmux-konfigurationen er linket:

```sh
git clone https://github.com/tmux-plugins/tpm \
  ~/.config/tmux/plugins/tpm
```

Start tmux og tryk `Ctrl+A` efterfulgt af `I` for at installere de konfigurerede
plugins.

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
readlink -f ~/.pi/agent/AGENTS.md
readlink -f ~/.pi/agent/models.json
readlink -f ~/.pi/agent/settings.json
readlink -f ~/.pi/agent/extensions/pi-permission-system/config.json
readlink -f ~/.pi/agent/skills/pdf-noter/SKILL.md
```
