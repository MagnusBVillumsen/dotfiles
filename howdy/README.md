# Howdy — ansigtslogin

Windows Hello-agtigt ansigtslogin via PAM, med Flow Z13'ens dedikerede
IR-kamera.

## Hardware

- **IR-kamera**: `/dev/video2` (640×360 greyscale, 15 fps).
- RGB-kameraet er `/dev/video0` (1920×1080).
- IR er vigtigt: virker i mørke og kan ikke snydes med et foto.
- Tjek enheder: `v4l2-ctl --list-devices`.

## Installation

Brug **`howdy-git`** — den stabile `howdy`-pakke (2.6.1) er outdated og bruger
`pam-python` + Python 2 (EOL). `howdy-git` bruger et kompileret `pam_howdy.so`.

```sh
yay -S howdy-git
```

## Konfiguration

```sh
sudo install -Dm644 ~/dotfiles/howdy/config.ini /etc/howdy/config.ini
```

Vigtige værdier i `config.ini`:

- `device_path = /dev/video2` — IR-kameraet.
- `workaround = input` — ansigt + password **samtidig** (ingen timeout-ventetid
  før password-prompten). `off` = vent på timeout; `native` = ustabil.

## OpenCV 5.0-patch

`sudo howdy test` crasher med OpenCV 5.0, fordi `calcHist` nu returnerer et
1-D-array i stedet for 2-D. Rettes med:

```sh
sudo sed -i 's/int(sum(hist)\[0\])/int(sum(hist))/' /usr/lib/howdy/cli/test.py
sudo sed -i 's/float(value\[0\])/float(value)/' /usr/lib/howdy/cli/test.py
```

## Enroll + test

```sh
sudo howdy add    # tilføj ansigtsmodel
sudo howdy test   # verificér kamera + detektion (rød cirkel = fundet ansigt)
```

`howdy test` viser kun **detektion**, ikke genkendelse. Genkendelsen testes via
PAM (sudo/login).

## PAM

Tilføj øverst i `/etc/pam.d/system-auth` (sudo/su) og
`/etc/pam.d/system-login` (login/låseskærm):

```
auth sufficient /usr/lib/security/pam_howdy.so
```

`sufficient` = fallback til den eksisterende password-auth, hvis ansigtet ikke
matcher.

Test: `sudo -k; sudo whoami` — skal vise `Identified face as <bruger>`.

## Sikkerhed

- Backup PAM-filerne før redigering, og hav en TTY (`Ctrl+Alt+F2`) klar ved
  første login-test.
- Snapshots er deaktiveret i config'en (`save_failed = false`,
  `save_successful = false`) — ellers gemmer Howdy billeder af login-forsøg,
  som kan misbruges.
