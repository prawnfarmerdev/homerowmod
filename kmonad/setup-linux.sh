#!/bin/bash
# Setup script for Homerow Mods on Linux

set -e

echo "=== Homerow Mods Linux Setup ==="

# 1. Add user to input group
echo "1. Adding user to 'input' group..."
if ! groups | grep -q input; then
    if command -v sudo &> /dev/null; then
        echo "Please enter your password to add user to input group:"
        sudo usermod -a -G input "$USER"
        echo "User added to input group."
        echo "You need to LOG OUT and back in for this to take effect."
    else
        echo "sudo not found. Run as root: usermod -a -G input $USER"
    fi
else
    echo "User already in 'input' group."
fi

# 2. Update sway config (remove caps:ctrl_modifier)
echo -e "\n2. Updating sway configuration..."
SWAY_CONFIG="$HOME/.config/sway/config"
if [ -f "$SWAY_CONFIG" ]; then
    if grep -q "caps:ctrl_modifier" "$SWAY_CONFIG"; then
        echo "Removing caps:ctrl_modifier from sway config..."
        sed -i '/xkb_options caps:ctrl_modifier/d' "$SWAY_CONFIG"
        sed -i 's/input type:keyboard {\s*}/input type:keyboard { }/' "$SWAY_CONFIG"
        echo "Sway config updated."
    else
        echo "Sway config already updated (no caps:ctrl_modifier)."
    fi
    
    # Remove KMonad exec line from sway config (using systemd instead)
    echo "Removing KMonad exec line from sway config (using systemd)..."
    sed -i '/# Start KMonad for Homerow Mods/d' "$SWAY_CONFIG"
    sed -i '/exec systemctl --user start kmonad-homerow.service/d' "$SWAY_CONFIG"
    
    echo "To apply sway changes, run: swaymsg reload"
else
    echo "Sway config not found at $SWAY_CONFIG"
    echo "If you use sway, manually remove 'xkb_options caps:ctrl_modifier' from input section."
fi

# 3. Set up systemd service
echo -e "\n3. Setting up systemd service..."
SERVICE_SOURCE="/home/okra/projects/homerowmod/kmonad/kmonad.service"
SERVICE_DEST="$HOME/.config/systemd/user/kmonad-homerow.service"

mkdir -p "$HOME/.config/systemd/user/"
cp "$SERVICE_SOURCE" "$SERVICE_DEST"
echo "Systemd service file installed to: $SERVICE_DEST"

# 4. Test KMonad config
echo -e "\n4. Testing KMonad configuration..."
if command -v kmonad &> /dev/null; then
    kmonad linux.kbd --dry-run && echo "Config syntax: OK"
else
    echo "KMonad not installed. Install from: https://github.com/kmonad/kmonad"
fi

echo -e "\n=== Setup Complete ==="
echo "Next steps (AFTER logging out and back in):"
echo "1. Enable the systemd service: systemctl --user enable kmonad-homerow.service"
echo "2. Start the service: systemctl --user start kmonad-homerow.service"
echo "3. Check status: systemctl --user status kmonad-homerow.service"
echo "4. For gaming: Hold Caps Lock >200ms to toggle gaming layer"
echo "5. To switch back: Hold Caps Lock again"
echo ""
echo "To manage the service:"
echo "  Stop: systemctl --user stop kmonad-homerow.service"
echo "  Restart: systemctl --user restart kmonad-homerow.service"
echo "  Disable autostart: systemctl --user disable kmonad-homerow.service"