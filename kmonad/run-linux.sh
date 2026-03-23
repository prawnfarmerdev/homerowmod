#!/bin/bash
# Script to start KMonad manually (for testing)
# Use ./manage-service.sh for systemd autostart

CONFIG_DIR="$(dirname "$0")"
CONFIG_FILE="$CONFIG_DIR/linux.kbd"

if ! command -v kmonad &> /dev/null; then
    echo "Error: KMonad not found. Please install KMonad first."
    exit 1
fi

echo "=== Manual KMonad Start ==="
echo "Note: For autostart, use: ./manage-service.sh enable-now"
echo ""

# Check if systemd service is running
if systemctl --user is-active kmonad-homerow.service >/dev/null 2>&1; then
    echo "Warning: systemd service is already running."
    echo "Stop it first: ./manage-service.sh stop"
    echo "Or use: ./manage-service.sh restart"
    exit 1
fi

# Check permissions
if ! groups | grep -q input; then
    echo "Error: User not in 'input' group."
    echo "Run ./setup-linux.sh and LOG OUT/IN first."
    exit 1
fi

echo "Starting KMonad manually with config: $CONFIG_FILE"
echo "Press Ctrl+C to stop"
echo ""
kmonad "$CONFIG_FILE"