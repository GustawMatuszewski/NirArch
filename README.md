# NirArch

Minimal, cohesive Wayland desktop config for **niri** on Arch Linux (also works on Fedora).

Dark theme with orange accents — every component shares the same look.

## What's Inside

```
alacritty/      Terminal config (themed selection colors, font)
niri/           Window manager config (outputs, keybinds, window rules, gestures)
waybar/         Status bar (battery, cpu, mem, temp, clock, network, audio, media, menus)
wofi/           App launcher & dmenu menus (centered, dark, orange border)
swaync/         Notification center (matches wofi/waybar style exactly)
swaylock/       Screen locker (screenshot blur, clock, orange ring)
scripts/        Glue that ties everything together
  ├── install-deps.sh    Interactive installer (Arch + Fedora)
  ├── apply-theme.sh     Change accent/bg colors globally in one place
  ├── menu.sh            Settings menu (audio, network, bluetooth, power)
  ├── audio-menu.sh      Audio control (mute, switch devices, pulsemixer TUI)
  ├── power-menu.sh      Lock, suspend, reboot, shutdown, logout
  ├── bat-notify.sh       Low battery notifications
  └── wall-cycle.sh       Random wallpaper rotation (swww)
globalStyle     Central color definitions (BG_COLOR, ACCENT_COLOR, TEXT_COLOR)
systemd/        PipeWire session manager symlink + wanted-by symlinks
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
1. Ask which optional apps you want (Discord, Steam, Brave, VSCode, Nautilus, GNOME Software)
2. Install core deps (niri, waybar, wofi, swaync, alacritty, swww, pulsemixer, bluetuith, swaylock, etc.)
3. Enable pipewire, NetworkManager, bluetooth
4. Set up multilib (Arch) or RPM Fusion (Fedora)

Then symlink/copy configs:

```bash
# Copy configs to ~/.config
cp -r alacritty waybar wofi swaync swaylock niri ~/.config/
mkdir -p ~/.config/scripts && cp scripts/*.sh ~/.config/scripts/
cp globalStyle ~/.config/globalStyle
chmod +x ~/.config/scripts/*.sh

# Add wallpapers
mkdir -p ~/.config/wallpapers
cp your-wallpapers/* ~/.config/wallpapers/

# systemd setup (PipeWire session manager)
mkdir -p ~/.config/systemd/user
cp systemd/user/pipewire-session-manager.service ~/.config/systemd/user/
cp systemd/user/pipewire.service.wants/* ~/.config/systemd/user/pipewire.service.wants/
cp systemd/user/sockets.target.wants/* ~/.config/systemd/user/sockets.target.wants/
systemctl --user daemon-reload

# font cache
fc-cache -f
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
| `Mod+Shift+Slash` | Hotkey overlay |
| `Mod+R` | Switch preset column width |
| `Mod+Minus/Equal` | Resize column ±10% |
| `XF86AudioRaiseVolume` | Volume +10% |
| `XF86AudioLowerVolume` | Volume -10% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioMicMute` | Toggle mic mute |
| `XF86MonBrightnessUp` | Brightness +10% |
| `XF86MonBrightnessDown` | Brightness -10% |

## TUI Tools

The menus launch proper TUI apps in floating alacritty windows:

- **Audio**: pulsemixer (full mixer with volume bars)
- **Bluetooth**: bluetuith (scan, pair, connect)
- **Network**: nmtui (wifi/ethernet config)
- **System Monitor**: btop (resource monitor)

## Dependencies

### Core (MUST have)

| Package | Purpose |
|---------|---------|
| `niri` | Wayland compositor |
| `waybar` | Status bar |
| `wofi` | App launcher |
| `swaync` | Notification center |
| `swaylock-effects` | Screen locker |
| `alacritty` | Terminal |
| `swww` | Wallpaper daemon |
| `pipewire` + `pipewire-pulse` + `pipewire-alsa` + `wireplumber` | Audio system |
| `NetworkManager` | Network management |
| `bluez` + `bluez-utils` | Bluetooth |
| `libnotify` | Notification daemon |
| `btop` | System monitor |
| `pavucontrol` | PulseAudio volume control |
| `pulsemixer` | Audio TUI mixer |
| `bluetuith-bin` | Bluetooth TUI |
| `playerctl` | Media player control |
| `brightnessctl` | Screen brightness control |
| `wpctl` | PipeWire control (from pipewire-utils) |

### Fonts

| Package | Purpose |
|---------|---------|
| `ttf-jetbrains-mono-nerd` (Arch) / `jetbrains-mono-fonts-all` (Fedora) | JetBrainsMono Nerd Font (icons + monospace) |
| `ttf-nerd-fonts-symbols-common` (Arch) / `nerd-fonts` (Fedora) | Nerd Font symbol pack |
| `noto-fonts-emoji` (Arch) / `google-noto-emoji-fonts` (Fedora) | Emoji glyphs |

### Optional

| Package | Purpose |
|---------|---------|
| `discord` | Discord client |
| `steam` (requires multilib/RPM Fusion) | Steam gaming |
| `brave-bin` (Arch) / `brave-browser` (Fedora) | Brave browser |
| `visual-studio-code-bin` (Arch) / `code` (Fedora) | VSCode |
| `nautilus` | GNOME Files |
| `gnome-software` | GNOME Software Store |

### Build Tools (Arch only)

| Package | Purpose |
|---------|---------|
| `base-devel` + `git` | Required to build yay from AUR |

### AUR Packages (Arch only)

| Package | Purpose |
|---------|---------|
| `niri` | Window manager |
| `wofi` | App launcher |
| `swaync` | Notification center |
| `swaylock-effects` | Screen locker |
| `swww` | Wallpaper daemon |
| `pulsemixer` | Audio TUI mixer |
| `bluetuith-bin` | Bluetooth TUI |
| `yay` | AUR helper (built from source) |

### Fedora Extras

| Package | Purpose |
|---------|---------|
| `rpmfusion-free` + `rpmfusion-nonfree` | Required for Steam/Discord |
| `fedora-cisco-openh264` | OpenH264 codec |
| `dnf-plugins-core` | dnf config-manager |
| `flatpak` + `flathub` | Flatpak for Discord/Steam |

## Outputs

- `eDP-1` (internal): 1920x1200 @ 60Hz, scale 1.2, positioned at x=0 y=-120
- `DP-1` (external): 1920x1080 @ 119.98Hz, scale 1, positioned at x=1920 y=0
- `HDMI-A-1` (external): 1920x1080 @ 75Hz, positioned at x=0 y=0

## Window Rules

| App/Title | Behavior |
|-----------|----------|
| `wezterm` | Default column width 50% |
| Firefox "Picture-in-Picture" | Open floating |
| `pavucontrol` | Open floating, 40% col width, 40% height |
| `btop-float` | Open floating, 60% col width, 70% height |
| `blue-float` | Open floating, 30% col width, 40% height |
| `nmtui-float` | Open floating, 40% col width, 60% height |
| `audio-float` | Open floating, 40% col width, 50% height |
| `swww-daemon` | Place within backdrop (visible in overview) |

## Gesture

- Swipe-to-workspace: threshold 30px, any direction
