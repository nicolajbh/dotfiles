#!/bin/bash
set -e # Exit on error

# 1. Fedora Package Installation
if [ -f /etc/fedora-release ]; then
  echo "Fedora detected. Installing packages..."
  sudo dnf install -y tmux neovim zoxide starship util-linux-user uv
  sudo dnf install -y dotnet-sdk-8.0
  
  if ! command -v qmk &> /dev/null; then
    echo "Installing QMK CLI..."
    uv tool install --with pip qmk
  fi
fi 

# 2. Colors and Paths
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 3. Symlink Function
create_symlink() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname "$target")"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mv "$target" "$target.backup"
    fi
    ln -sf "$source" "$target"
    echo -e "${GREEN}✓ Linked $source -> $target${NC}"
}

echo -e "${GREEN}Setting up configuration files...${NC}"

# Cross-platform configs
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"

# macOS only configs
if [[ "$OSTYPE" == "darwin"* ]]; then
    create_symlink "$DOTFILES_DIR/config/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
    create_symlink "$DOTFILES_DIR/config/karabiner" "$HOME/.config/karabiner"
fi

echo -e "${GREEN}✓ Dotfiles installation complete!${NC}"cho -e "${YELLOW}You may need to reload your applications to pick up the new configs.${NC}"
