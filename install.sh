#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="nic-repo"
PACMAN_CONF="/etc/pacman.conf"
RAW_BASE="https://raw.githubusercontent.com/microservice-tech-nicolas/arch-packages/main"
REPO_SERVER="${RAW_BASE}/repo/stable/\$arch"

echo ""
echo "  nic-repo installer"
echo "  =================="
echo ""

# ── 1. Add repo to pacman.conf ──────────────────────────────────────────────
if grep -q "\[${REPO_NAME}\]" "${PACMAN_CONF}"; then
  echo "  [skip] ${REPO_NAME} already in ${PACMAN_CONF}"
else
  echo "  [+] Adding [${REPO_NAME}] to ${PACMAN_CONF}..."
  sudo tee -a "${PACMAN_CONF}" > /dev/null <<EOF

[${REPO_NAME}]
SigLevel = Optional TrustAll
Server = ${REPO_SERVER}
EOF
  echo "  [ok] Repo added."
fi

# ── 2. Sync package databases ────────────────────────────────────────────────
echo "  [+] Syncing package databases..."
sudo pacman -Sy --noconfirm

# ── 3. Install packages ──────────────────────────────────────────────────────
echo "  [+] Installing nic-nvim and nic-dotfiles..."
sudo pacman -S --noconfirm nic-nvim nic-dotfiles

echo ""
echo "  Done!"
echo "  - Neovim is available as 'nvim'"
echo "  - Your dotfiles are checked out into \$HOME"
echo "  - Use 'dot' as your dotfiles git command (open a new shell first)"
echo ""
