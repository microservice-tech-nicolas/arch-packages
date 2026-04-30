# arch-packages

Nicolas custom Arch Linux package repository.

Packages are built with `makepkg` and hosted here so they can be consumed like
plain `pacman` packages on any Arch install.

## Packages

| Package | Description |
|---|---|
| `nic-nvim` | Neovim latest stable, built from source |
| `nic-dotfiles` | Bare git clone of [arch-dotfiles](https://github.com/microservice-tech-nicolas/arch-dotfiles) into `$HOME` |

## Using this repo on a fresh Arch install

Add the custom repo to `/etc/pacman.conf`:

```ini
[nic-repo]
SigLevel = Optional TrustAll
Server = https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/repo/$arch
```

Then sync and install:

```sh
sudo pacman -Sy
sudo pacman -S nic-nvim nic-dotfiles
```

## Building packages locally

```sh
git clone https://github.com/microservice-tech-nicolas/arch-packages.git
cd arch-packages/nic-nvim
makepkg -si

cd ../nic-dotfiles
makepkg -si
```

## Maintaining the repo

After building a package, add it to the repo database:

```sh
# From repo root
mkdir -p repo/x86_64
cp nic-nvim/*.pkg.tar.zst repo/x86_64/
repo-add repo/x86_64/nic-repo.db.tar.gz repo/x86_64/*.pkg.tar.zst
git add repo/ && git commit -m "repo: update packages" && git push
```
