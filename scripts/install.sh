#!/bin/bash
set -e # Exit on error

# 1. Fedora Package Installation
if [ -f /etc/fedora-release ]; then
  echo "Fedora detected. Installing packages..."
  # Added fish and util-linux-user for shell management
  sudo dnf install -y tmux neovim zoxide starship util-linux-user uv fish
  sudo dnf install -y dotnet-sdk-8.0
  
  if ! command -v qmk &> /dev/null; then
    echo "Installing QMK CLI..."
    uv tool install --with pip qmk
  fi

  # Set Fish as the default shell
  if [ "$SHELL" != "$(which fish)" ]; then
    echo "Changing default shell to fish..."
    sudo chsh -s $(which fish) $USER
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

# Core development configs
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/config/yazi" "$HOME/.config/yazi"

# 4. Shell Configuration (Fish)
echo -e "${GREEN}Configuring Fish shell...${NC}"
mkdir -p "$HOME/.config/fish"
cat << 'EOF' > "$HOME/.config/fish/config.fish"
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
end
EOF

echo -e "${GREEN}✓ Dotfiles installation complete!${NC}"
echo -e "${YELLOW}Note: Your WezTerm config should be placed in your Windows home directory for best performance.${NC}"cho -e "${YELLOW}Note: Your WezTerm config should be placed in your Windows home directory for best performance.${NC}"cho -e "${GREEN}✓ Dotfiles installation complete!${NC}"cho -e "${YELLOW}You may need to reload your applications to pick up the new configs.${NC}"
