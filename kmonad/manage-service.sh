#!/bin/bash
# Script to manage KMonad systemd service

SERVICE="kmonad-homerow.service"
CONFIG_DIR="$(dirname "$0")"

case "${1:-}" in
    enable|start|stop|restart|status|enable-now|disable)
        cmd="$1"
        ;;
    *)
        echo "Usage: $0 {enable|enable-now|start|stop|restart|status|disable}"
        echo ""
        echo "Commands:"
        echo "  enable      - Enable service to start at login"
        echo "  enable-now  - Enable and start service immediately"
        echo "  start       - Start service (already enabled)"
        echo "  stop        - Stop service"
        echo "  restart     - Restart service"
        echo "  status      - Show service status"
        echo "  disable     - Disable and stop service"
        exit 1
        ;;
esac

# Check if user is in input group
if ! groups | grep -q input; then
    echo "Warning: User not in 'input' group."
    echo "Run ./setup-linux.sh and LOG OUT/IN first."
    if [[ "$cmd" != "status" ]]; then
        exit 1
    fi
fi

# Check if systemd user instance is running
if ! systemctl --user status >/dev/null 2>&1; then
    echo "Error: systemd user instance not running."
    echo "Try: systemctl --user start"
    exit 1
fi

case "$cmd" in
    enable)
        echo "Enabling $SERVICE to start at login..."
        systemctl --user enable "$SERVICE"
        echo "Service enabled. It will start on next login."
        ;;
    enable-now)
        echo "Enabling and starting $SERVICE..."
        systemctl --user enable --now "$SERVICE"
        systemctl --user status "$SERVICE"
        ;;
    start)
        echo "Starting $SERVICE..."
        systemctl --user start "$SERVICE"
        systemctl --user status "$SERVICE"
        ;;
    stop)
        echo "Stopping $SERVICE..."
        systemctl --user stop "$SERVICE"
        systemctl --user status "$SERVICE" 2>/dev/null || echo "Service stopped."
        ;;
    restart)
        echo "Restarting $SERVICE..."
        systemctl --user restart "$SERVICE"
        systemctl --user status "$SERVICE"
        ;;
    status)
        systemctl --user status "$SERVICE"
        ;;
    disable)
        echo "Disabling $SERVICE..."
        systemctl --user disable --now "$SERVICE"
        echo "Service disabled and stopped."
        ;;
esac