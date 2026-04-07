#!/bin/bash

# 1. THE INTERVIEW (Clear and specific)
echo "------------------------------------------------"
echo "   SYSTEM SETUP: OPTIONAL APPLICATION MENU"
echo "------------------------------------------------"
echo "Answer [y] for Yes or [n] for No for each app:"
echo ""

# Helper to make the questions look clean
ask_app() {
    echo -n "󰏖 Would you like to install $1? [y/n]: "
    read -r choice
    case "$choice" in 
        [yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Collect choices one by one
if ask_app "GNOME Files (Nautilus)"; then WANT_NAUTILUS=true; fi
if ask_app "GNOME Software (Store)"; then WANT_SOFTWARE=true; fi
if ask_app "Discord (Native)"; then WANT_DISCORD=true; fi
if ask_app "Steam (Native/Multilib)"; then WANT_STEAM=true; fi
if ask_app "Brave Browser"; then WANT_BRAVE=true; fi
if ask_app "Visual Studio Code"; then WANT_VSCODE=true; fi

echo ""
echo "󰄬 Selection complete. Preparing system..."
echo "------------------------------------------------"

# 2. GET SUDO POWER
echo "󰒲 Enter your password to start installation:"
sudo -v
# Keep-alive loop
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# 3. DISTRO DETECTION
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "󰚌 Cannot detect distro."
    exit 1
fi

# 4. REPOSITORY SETUP (Fedora/Arch Specifics)
if [[ "$DISTRO" == "arch" ]]; then
    # Enable multilib for Steam/Discord
    if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
        echo "󰮄 Enabling Multilib (Arch)..."
        echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
        sudo pacman -Sy
    fi
    # Setup yay for AUR apps
    if ! command -v yay &> /dev/null; then
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm && cd -
    fi
    INSTALL_CMD="yay -S --needed --noconfirm"
elif [[ "$DISTRO" == "fedora" ]]; then
    # Enable RPM Fusion for Steam/Discord
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf config-manager --set-enabled fedora-cisco-openh264
    sudo dnf install -y dnf-plugins-core
    INSTALL_CMD="sudo dnf install -y"
fi

# 5. CORE INSTALLATION (Stuff your scripts MUST have)
echo "󰄬 Installing core script dependencies..."
if [[ "$DISTRO" == "arch" ]]; then
    $INSTALL_CMD niri wofi alacritty waybar swaync pipewire pipewire-pulse pipewire-alsa wireplumber networkmanager bluez bluez-utils swww libnotify btop pavucontrol pulsemixer bluetuith-bin swaylock ttf-nerd-fonts-symbols-common ttf-jetbrains-mono-nerd noto-fonts-emoji
elif [[ "$DISTRO" == "fedora" ]]; then
    $INSTALL_CMD niri wofi alacritty waybar swaync pipewire-pulseaudio pipewire-utils wireplumber NetworkManager bluez bluez-utils swww libnotify btop pavucontrol pulsemixer swaylock google-noto-emoji-fonts jetbrains-mono-fonts-all nerd-fonts flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# 6. OPTIONAL APPS INSTALLATION
echo "󰏖 Installing your selected apps..."

[[ "$WANT_NAUTILUS" == true ]] && $INSTALL_CMD nautilus
[[ "$WANT_SOFTWARE" == true ]] && $INSTALL_CMD gnome-software
[[ "$WANT_DISCORD" == true ]]  && $INSTALL_CMD discord
[[ "$WANT_STEAM" == true ]]    && $INSTALL_CMD steam

if [[ "$WANT_BRAVE" == true ]]; then
    if [[ "$DISTRO" == "arch" ]]; then
        $INSTALL_CMD brave-bin
    else
        sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        $INSTALL_CMD brave-browser
    fi
fi

if [[ "$WANT_VSCODE" == true ]]; then
    if [[ "$DISTRO" == "arch" ]]; then
        $INSTALL_CMD visual-studio-code-bin
    else
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        $INSTALL_CMD code
    fi
fi

# 7. SERVICE SETUP (Force the audio/network to work)
echo "󰄬 Configuring system daemons..."
sudo systemctl enable --now NetworkManager bluetooth
systemctl --user unmask pipewire.service pipewire-pulse.service wireplumber.service
systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service

# 8. PERMISSIONS
chmod +x ~/.config/scripts/*.sh
mkdir -p "$HOME/.config/wallpapers"
fc-cache -f &> /dev/null

echo "------------------------------------------------"
echo "󰄬 INSTALLATION COMPLETE"
echo "------------------------------------------------"
