# arch-packages

Nicolas custom Arch Linux package repository.
Packages are built automatically via GitHub Actions on an Arch Linux container and published here.

---

## Fresh Arch install — one command

**Step 1 — add the repo and sync:**

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/install.sh)
```

**Step 2 — install everything:**

```sh
sudo pacman -S arch-full
```

`arch-full` pulls in all packages below in the correct order as dependencies.

---

## Packages

### Meta

| Package | Description |
|---|---|
| `arch-full` | Installs everything below in one command |

### Core

| Package | Installs | Post-install |
|---|---|---|
| `arch-core` | zsh, kitty, fastfetch, git, zoxide, eza, lsd, JetBrainsMono + Inconsolata Nerd Fonts, Terminus (TTY font) | Sets zsh as default shell, installs oh-my-zsh, sets TTY font, wires kitty font hint, installs TPM |
| `arch-dev` | tmux, lazygit, fzf, zoxide | Installs TPM + tmux plugins |
| `arch-pass` | pass, direnv, gnupg | — |

### Desktop

| Package | Installs | Post-install |
|---|---|---|
| `arch-gui-sway` | sddm, wayland, xwayland, sway, swaybg, swayidle, swaylock, waybar, swaync, rofi-wayland, grim, slurp, swappy, pipewire, wireplumber, easyeffects, playerctl, wl-clipboard, cliphist, noto-fonts, papirus-icon-theme, xdg-portals, firefox, qutebrowser | Enables pipewire user services |
| `arch-eyecandy` | python-pywal, swww, starship, fzf, libnotify | Wires starship into zsh/bash, creates `~/Pictures/wallpapers/`, makes fzfmenu scripts executable |

### Editor

| Package | Installs | Post-install |
|---|---|---|
| `nic-nvim` | Neovim latest stable (built from source), ripgrep, fd, fzf, lazygit, tree-sitter, python-pynvim, nodejs, npm, perl, wl-clipboard, xdg-utils | Installs `npm install -g neovim` and `cpanm Neovim::Ext` |
| `nic-dotfiles` | — (meta) | Bare-clones [arch-dotfiles](https://github.com/microservice-tech-nicolas/arch-dotfiles) into `$HOME`, checks out all configs |

### Ops

| Package | Installs | Post-install |
|---|---|---|
| `arch-ops` | kubectl, helm, k9s, minikube, docker, docker-compose, docker-buildx | Enables docker.service, adds user to docker group |
| `arch-ai` | nodejs, npm, curl | Installs claude-code (native installer), opencode, crush |

---

## Dotfiles

All configs live in [`arch-dotfiles`](https://github.com/microservice-tech-nicolas/arch-dotfiles) and are checked out into `$HOME` by `nic-dotfiles`. Included:

| Config | Location |
|---|---|
| Neovim (LazyVim) | `~/.config/nvim/` |
| Sway | `~/.config/sway/` |
| Waybar | `~/.config/waybar/` |
| Kitty | `~/.config/kitty/` |
| Tmux | `~/.config/tmux/` |
| Starship | `~/.config/starship.toml` |
| Fastfetch | `~/.config/fastfetch/` |
| Lazygit | `~/.config/lazygit/` |
| Lazydocker | `~/.config/lazydocker/` |
| swaync | `~/.config/swaync/` |
| wlogout | `~/.config/wlogout/` |
| fzfmenu scripts | `~/.config/fzfmenu/` |
| zshrc / zprofile | `~/.zshrc`, `~/.zprofile` |

After install, manage dotfiles with the `dot` alias:

```sh
dot status
dot add .config/nvim/init.lua
dot commit -m "nvim: tweak config"
dot push
```

---

## Wallpaper & theming

`arch-eyecandy` sets up the full pywal workflow copied from this machine:

- Drop wallpapers into `~/Pictures/wallpapers/`
- Press `Mod+b` in sway to open the fuzzy picker with image preview
- Selecting an image runs `wal-apply` which in one shot:
  - Generates a colorscheme via `wal -i`
  - Sets the animated wallpaper via `swww img`
  - Reloads kitty, waybar CSS, rofi, tmux, sway borders, fzfmenu, nvim, qutebrowser

---

## API keys

Never hardcode API keys in `.zshrc`. Store with `pass` and load on demand:

```sh
pass insert api/anthropic
pass insert api/openrouter
```

The `.zshrc` in dotfiles has the commented-out load lines ready:

```sh
# export ANTHROPIC_API_KEY=$(pass show api/anthropic 2>/dev/null)
# export OPENROUTER_API_KEY=$(pass show api/openrouter 2>/dev/null)
```

---

## Channels

| Channel | Branch | Use |
|---|---|---|
| `stable` | `main` | Daily use — only merges after successful build |
| `dev` | `dev` | Testing — all pushes |

To use the dev channel instead, add to `/etc/pacman.conf`:

```ini
[nic-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/dev/repo/dev/$arch
```

---

## How builds work

- Each package is built in **parallel** on a separate Arch Linux container via GitHub Actions matrix
- Only packages whose `PKGBUILD` changed are rebuilt — unchanged ones are reused
- `pacman` package cache is preserved across runs for faster builds
- Neovim version is fetched from the GitHub releases API automatically — always latest stable
- `pkgrel` increments only when the `PKGBUILD` itself changes
- Only published to the pacman database on a fully successful build
- `arch-full` is a meta-package only — it has no build step, just declares all others as dependencies
