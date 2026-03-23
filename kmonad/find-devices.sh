#!/bin/bash
# Helper script to find keyboard input devices for KMonad

echo "Listing input devices:"
ls -la /dev/input/by-id/ 2>/dev/null || echo "/dev/input/by-id/ not found"

echo -e "\n--- Available event devices ---"
ls /dev/input/event* 2>/dev/null | head -10

echo -e "\n--- Suggested keyboard devices (from by-id) ---"
for dev in /dev/input/by-id/*; do
    if [[ "$dev" != *"-mouse"* ]] && [[ "$dev" != *"-touchpad"* ]] && [[ "$dev" != *"-joystick"* ]]; then
        echo "$dev -> $(readlink -f "$dev")"
    fi
done

echo -e "\nTo use device-file input, uncomment and edit the line in linux.kbd:"
echo "input  (device-file \"/dev/input/by-id/...\")"
echo ""
echo "You may need to add your user to the 'input' group:"
echo "sudo usermod -a -G input $USER"
echo "Then log out and back in."