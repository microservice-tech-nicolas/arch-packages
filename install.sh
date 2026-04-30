#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main/repo/stable/\$arch"
PACMAN_CONF="/etc/pacman.conf"
REPO_ENTRY="[nic-repo]\nSigLevel = Optional TrustAll\nServer = ${REPO_URL}"

echo "==> Adding nic-repo to pacman..."

if grep -q '\[nic-repo\]' "${PACMAN_CONF}"; then
  echo "==> nic-repo already present in ${PACMAN_CONF}, skipping."
else
  # Insert before [core]
  sudo sed -i "s|\[core\]|${REPO_ENTRY}\n\n[core]|" "${PACMAN_CONF}"
  echo "==> Added nic-repo to ${PACMAN_CONF}"
fi

echo "==> Syncing package database..."
sudo pacman -Sy

echo "==> Installing nic packages..."
sudo pacman -S --noconfirm nic-nvim nic-dotfiles

echo ""
echo "Done! Your dotfiles are checked out. Open a new shell to use the 'dot' alias."
