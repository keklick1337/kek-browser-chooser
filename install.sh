#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="/usr/local/bin"
DESKTOP_DIR="${HOME}/.local/share/applications"
ICON_DIR="${HOME}/.local/share/icons/hicolor/256x256/apps"

echo "Installing Browser Chooser..."

# Create directories if they don't exist
mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"

# Install script (requires sudo)
echo "Installing script to $INSTALL_DIR (requires sudo)..."
sudo cp "$SCRIPT_DIR/browser-chooser" "$INSTALL_DIR/browser-chooser"
sudo chmod +x "$INSTALL_DIR/browser-chooser"

# Install icon
if [ -f "$SCRIPT_DIR/icon.png" ]; then
    echo "Installing icon..."
    cp "$SCRIPT_DIR/icon.png" "$ICON_DIR/browser-chooser.png"
fi

# Install desktop file
echo "Installing desktop file..."
cp "$SCRIPT_DIR/browser-chooser.desktop" "$DESKTOP_DIR/browser-chooser.desktop"

# Update desktop database
if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
fi

# Update icon cache
if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache -f -t "${HOME}/.local/share/icons/hicolor" 2>/dev/null || true
fi

echo ""
echo "Installation complete!"
echo ""
echo "You can now:"
echo "  1. Set as default browser:"
echo "     xdg-settings set default-web-browser browser-chooser.desktop"
echo ""
echo "  2. Or replace xdg-open:"
echo "     sudo mv /usr/bin/xdg-open /usr/bin/xdg-open.original"
echo "     sudo ln -s $INSTALL_DIR/browser-chooser /usr/bin/xdg-open"
echo ""
