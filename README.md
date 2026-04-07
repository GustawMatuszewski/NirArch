# NirArch

Minimal, cohesive Wayland desktop config for **niri** on Arch (also works on Fedora).

Dark theme with orange accents — every component shares the same look.

## What's Inside

```
alacritty/      Terminal config (themed selection colors)
niri/           Window manager config (borders, keybinds, window rules)
waybar/         Status bar (battery, cpu, mem, temp, clock, network, audio, menus)
wofi/           App launcher & dmenu menus (centered, dark, orange border)
swaync/         Notification center (matches wofi/waybar style exactly)
scripts/        Glue that ties everything together
  ├── install-deps.sh    Interactive installer (Arch + Fedora)
  ├── apply-theme.sh     Change accent/bg colors globally in one place
  ├── menu.sh            Settings menu (audio, network, bluetooth, power)
  ├── audio-menu.sh      Audio control (mute, switch devices, pulsemixer TUI)
  ├── power-menu.sh      Lock, suspend, reboot, shutdown, logout
  ├── bat-notify.sh       Low battery notifications
  └── wall-cycle.sh       Random wallpaper rotation (swww)
globalStyle     Central color definitions (BG_COLOR, ACCENT_COLOR, TEXT_COLOR)
```

## Theme

Edit `globalStyle` to change colors, then run `apply-theme.sh`:

```
BG_COLOR="#2c2929"
ACCENT_COLOR="#e69934"
TEXT_COLOR="#ffffff"
```

All configs (wofi, waybar, swaync, alacritty, niri borders) update at once.

## Install

```bash
git clone https://github.com/YOUR_USER/NirArch.git
cd NirArch
bash scripts/install-deps.sh
```

The installer will:
1. Ask which optional apps you want (Discord, Steam, Brave, VSCode, etc.)
2. Install core deps (niri, waybar, wofi, swaync, alacritty, swww, pulsemixer, bluetuith, etc.)
3. Enable pipewire, NetworkManager, bluetooth

Then symlink/copy configs:

```bash
# Copy configs to ~/.config
cp -r alacritty waybar wofi swaync niri ~/.config/
mkdir -p ~/.config/scripts && cp scripts/*.sh ~/.config/scripts/
cp globalStyle ~/.config/globalStyle
chmod +x ~/.config/scripts/*.sh

# Add wallpapers
cp your-wallpapers/* ~/.config/wallpapers/
```

## Keybinds

| Key | Action |
|-----|--------|
| `Mod+Return` | Terminal (alacritty) |
| `Mod+M` | App launcher (wofi) |
| `Mod+Alt+M` | Settings menu |
| `Mod+Q` | Close window |
| `Mod+F` | Maximize |
| `Mod+O` | Overview |
| `Mod+D` | Fuzzel |
| `Super+Alt+L` | Lock (swaylock) |
| `Mod+1-9` | Workspaces |

## TUI Tools

The menus launch proper TUI apps in floating alacritty windows:

- **Audio**: pulsemixer (full mixer with volume bars)
- **Bluetooth**: bluetuith (scan, pair, connect)
- **Network**: nmtui (wifi/ethernet config)
- **System Monitor**: btop (resource monitor)

## Dependencies

Core: `niri waybar wofi swaync alacritty swww pipewire wireplumber pulsemixer bluetuith swaylock btop libnotify`

Fonts: `JetBrainsMono Nerd Font`, `Noto Emoji`
