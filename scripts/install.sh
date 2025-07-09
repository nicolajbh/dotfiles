#!/bin/bash

# Dotfiles installation script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Installing dotfiles from $DOTFILES_DIR${NC}"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # If target exists and is not a symlink, back it up
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo -e "${YELLOW}Backing up existing $target to $target.backup${NC}"
        mv "$target" "$target.backup"
    fi
    
    # Remove existing symlink if it exists
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓ Linked $source -> $target${NC}"
}

# Install configs
echo -e "${GREEN}Setting up configuration files...${NC}"

# Ghostty
create_symlink "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"

# AeroSpace
create_symlink "$DOTFILES_DIR/config/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"

# tmux
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo -e "${GREEN}✓ Dotfiles installation complete!${NC}"
echo -e "${YELLOW}You may need to reload your applications to pick up the new configs.${NC}"
