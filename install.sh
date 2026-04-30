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

# ── Add repo to pacman.conf ──────────────────────────────────────────────────
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

# ── Sync package databases ───────────────────────────────────────────────────
echo "  [+] Syncing package databases..."
sudo pacman -Sy --noconfirm

echo ""
echo "  nic-repo is ready. Available packages:"
echo ""
echo "    nic-nvim       Neovim latest stable, built from source"
echo "    nic-dotfiles   Bare git clone dotfiles into \$HOME"
echo ""
echo "  Install what you need:"
echo "    sudo pacman -S nic-nvim"
echo ""
