# arch-packages

Nicolas custom Arch Linux package repository.  
Packages are built automatically via GitHub Actions on an Arch Linux container and published here.

## Packages

| Package | Description |
|---|---|
| `nic-nvim` | Neovim latest stable, built from source |
| `nic-dotfiles` | Bare git clone of [arch-dotfiles](https://github.com/microservice-tech-nicolas/arch-dotfiles) into `$HOME` |

## Fresh Arch install — one command

```sh
bash <(curl -fsSL https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/install.sh)
```

This will:
1. Add `[nic-repo]` to `/etc/pacman.conf`
2. Sync the package database

Then install whatever you need via pacman:

```sh
sudo pacman -S nic-nvim
sudo pacman -S nic-dotfiles
```

## Channels

| Channel | Branch | Stability |
|---|---|---|
| `stable` | `main` | production — built on every push to main |
| `dev` | `dev` | cutting edge — all pushes to dev branch |

## Manual pacman setup

Add to `/etc/pacman.conf` (anywhere above `[core]`):

```ini
[nic-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/repo/stable/$arch
```

Then:

```sh
sudo pacman -Sy
sudo pacman -S nic-nvim nic-dotfiles
```

## Managing dotfiles

After install, use `dot` like git from anywhere in `$HOME`:

```sh
dot status
dot add .config/nvim/init.lua
dot commit -m "nvim: initial config"
dot push
```

## How builds work

- Any push to `nic-*/PKGBUILD` on `main` or `dev` triggers a GitHub Actions build
- Built on an official `archlinux` container using `makepkg`
- Neovim version is fetched automatically from the GitHub releases API — always latest stable
- `pkgrel` is auto-incremented based on commit history
- Only published to the pacman repo on a fully successful build
- `main` → `repo/stable/x86_64/` | `dev` → `repo/dev/x86_64/`
