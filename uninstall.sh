#!/bin/bash

set -euo pipefail

INSTALL_DIR="/usr/local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICON_DIR="${HOME}/.local/share/icons/hicolor/256x256/apps"

echo "Uninstalling Browser Chooser..."

# Remove script (requires sudo)
if [ -f "$INSTALL_DIR/browser-chooser" ]; then
    echo "Removing script (requires sudo)..."
    sudo rm -f "$INSTALL_DIR/browser-chooser"
fi

# Remove desktop file
if [ -f "$DESKTOP_DIR/browser-chooser.desktop" ]; then
    echo "Removing desktop file..."
    rm -f "$DESKTOP_DIR/browser-chooser.desktop"
fi

# Remove icon
if [ -f "$ICON_DIR/browser-chooser.png" ]; then
    echo "Removing icon..."
    rm -f "$ICON_DIR/browser-chooser.png"
fi

# Update desktop database
if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
fi

# Update icon cache
if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache -f -t "${HOME}/.local/share/icons/hicolor" 2>/dev/null || true
fi

# Check if xdg-open was replaced
if [ -L "/usr/bin/xdg-open" ] && [ "$(readlink /usr/bin/xdg-open)" = "$INSTALL_DIR/browser-chooser" ]; then
    echo ""
    echo "WARNING: /usr/bin/xdg-open is symlinked to browser-chooser"
    echo "To restore original xdg-open, run:"
    echo "  sudo rm /usr/bin/xdg-open"
    echo "  sudo mv /usr/bin/xdg-open.original /usr/bin/xdg-open"
fi

echo ""
echo "Uninstallation complete!"
