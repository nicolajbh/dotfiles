# Dotfiles

My personal dotfiles for macOS development setup.

## Setup

### Applications
- **Ghostty**: Terminal emulator with Gruvbox theme
- **AeroSpace**: Tiling window manager
- **tmux**: Terminal multiplexer

### Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x scripts/install.sh
./scripts/install.sh
```

## Configuration Details

### Ghostty (`~/.config/ghostty/config`)
- Gruvbox Dark Hard theme
- 80% opacity with blur
- Font size 19
- Left Option key as Alt
- No window decorations

### AeroSpace (`~/.aerospace.toml`)
- Vim-style navigation (Alt + h/j/k/l)
- 5 workspaces with app assignments:
  - Workspace 1: Ghostty/Terminal
  - Workspace 2: Safari/Brave
  - Workspace 4: Discord
  - Workspace 5: Preview/PDFs
- Alt + numbers for workspace switching

### tmux (`~/.tmux.conf`)
- Backtick (`) as prefix key
- Vim-style pane navigation
- Vi copy mode with system clipboard integration
- Mouse support enabled
- Custom status bar styling

## Key Bindings

### AeroSpace
- `Alt + h/j/k/l` - Focus windows
- `Alt + 1-5` - Switch workspaces
- `Alt + Shift + h/j/k/l` - Move windows
- `Alt + Shift + 1-5` - Move windows to workspaces

### tmux
- `` ` `` - Prefix key
- `` ` | `` - Split vertically
- `` ` - `` - Split horizontally
- `` ` h/j/k/l `` - Navigate panes
- `` ` c `` - New window
- `` ` d `` - Detach session

## Directory Structure

```
dotfiles/
├── config/
│   ├── ghostty/
│   │   └── config
│   └── aerospace/
│       └── .aerospace.toml
├── tmux/
│   └── .tmux.conf
├── install.sh
└── README.md
```
