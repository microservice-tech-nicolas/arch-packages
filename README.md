# arch-packages

Nicolas custom Arch Linux package repository.  
Packages are built automatically via GitHub Actions on an Arch Linux container and published here.

## Packages

| Package | Description |
|---|---|
| `nic-nvim` | Neovim latest stable, built from source |
| `nic-dotfiles` | Bare git clone of [arch-dotfiles](https://github.com/microservice-tech-nicolas/arch-dotfiles) into `$HOME` |

## Channels

| Channel | Branch | Stability |
|---|---|---|
| `stable` | `main` | production — only tagged/reviewed builds |
| `dev` | `dev` | cutting edge — all pushes |

## Add to pacman

Edit `/etc/pacman.conf` and add **one** of the following above `[core]`:

**Stable (recommended):**
```ini
[nic-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/repo/stable/$arch
```

**Dev:**
```ini
[nic-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/dev/repo/dev/$arch
```

Then:
```sh
sudo pacman -Sy
sudo pacman -S nic-nvim nic-dotfiles
```

## Install script (fresh Arch box)

```sh
curl -fsSL https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/install.sh | bash
```

## Managing dotfiles after install

```sh
dot add .config/nvim/init.lua
dot commit -m "nvim: initial config"
dot push
```

## Local build

```sh
git clone https://github.com/microservice-tech-nicolas/arch-packages.git
cd arch-packages/nic-nvim && makepkg -si
cd ../nic-dotfiles && makepkg -si
```
