#!/bin/bash
set -e 

# 1. Fedora Package Installation
if [ -f /etc/fedora-release ]; then
  echo "Fedora detected. Installing packages..."

# Enable COPR for starship before installing
  sudo dnf copr enable -y atim/starship

  sudo dnf install -y tmux neovim zoxide starship util-linux-user uv fish
  sudo dnf install -y dotnet-sdk-8.0
  
  # Set Fish as the default shell
  if [ "$SHELL" != "$(which fish)" ]; then
    sudo chsh -s $(which fish) $USER
  fi
fi 

# 2. Paths
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 3. Symlink Function
create_symlink() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo -e "✓ Linked $source -> $target"
}

# 4. Apply Linux-side Configs ONLY
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/config/yazi" "$HOME/.config/yazi"

# 5. Fish Initialization
mkdir -p "$HOME/.config/fish"
cat << 'EOF' > "$HOME/.config/fish/config.fish"
if status is-interactive
    starship init fish | source
    zoxide init fish | source
end
EOF

echo "Setup complete!" 
