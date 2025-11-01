# Browser Chooser

An interactive browser and profile selector for Linux. Can be used as an `xdg-open` replacement or set as the default browser.

## Features

- Interactive browser selection dialog
- Support for multiple browser profiles (Firefox, Chrome, Chromium)
- Fallback to original `xdg-open` if no selection is made
- Multiple dialog backend support (kdialog, zenity, rofi)

## Dependencies

### Required
- `bash` (version 4.0+)
- `jq` - JSON processor for reading Chrome/Chromium profiles
- `awk` - for parsing Firefox profiles

### Dialog Backends (at least one required)
- `kdialog` - KDE dialog
- `zenity` - GNOME/GTK dialog
- `rofi` - standalone menu/dialog

### Optional
- `firefox` or `firefox-esr`
- `google-chrome-stable` or `google-chrome`
- `chromium`

## Installation

### Quick Install (Recommended)

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

This will install the script, desktop file, and icon to your home directory.

Then choose one of the following:

**Option 1: Set as default browser**
```bash
xdg-settings set default-web-browser browser-chooser.desktop
```

**Option 2: Replace xdg-open (requires sudo)**
```bash
sudo mv /usr/bin/xdg-open /usr/bin/xdg-open.original
sudo ln -s ~/.local/bin/browser-chooser /usr/bin/xdg-open
```

### Manual Installation

### Method 1: Replace xdg-open

1. Backup the original `xdg-open`:
```bash
sudo mv /usr/bin/xdg-open /usr/bin/xdg-open.original
```

2. Install the script (choose one):

   **Option A: Symlink (recommended - easy updates)**
   ```bash
   sudo ln -s /path/to/browser-chooser /usr/bin/xdg-open
   ```

   **Option B: Copy**
   ```bash
   sudo cp browser-chooser /usr/bin/xdg-open
   sudo chmod +x /usr/bin/xdg-open
   ```

### Method 2: Set as default browser

Create a desktop entry:

```bash
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/browser-chooser.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Name=Browser Chooser
Comment=Choose browser and profile for opening links
Exec=/path/to/browser-chooser %u
Type=Application
Terminal=false
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
Categories=Network;WebBrowser;
EOF
```

Then set it as default:
```bash
xdg-settings set default-web-browser browser-chooser.desktop
```

## Configuration

You can override browser profile directories using environment variables:

```bash
export FIREFOX_PROFILES_DIR="$HOME/.mozilla/firefox"
export CHROME_CONFIG_DIR="$HOME/.config/google-chrome"
export CHROMIUM_CONFIG_DIR="$HOME/.config/chromium"
```

## Uninstallation

Run the uninstallation script:

```bash
./uninstall.sh
```

Or manually:

**If installed as xdg-open replacement:**
```bash
sudo rm /usr/bin/xdg-open
sudo mv /usr/bin/xdg-open.original /usr/bin/xdg-open
```

**If set as default browser:**
```bash
rm ~/.local/share/applications/browser-chooser.desktop
rm ~/.local/bin/browser-chooser
xdg-settings set default-web-browser firefox.desktop  # or your preferred browser
```

## Usage

When opening a URL or file:

```bash
browser-chooser https://example.com
```

Or if installed as xdg-open replacement:

```bash
xdg-open https://example.com
```

A dialog will appear allowing you to select the browser and profile to use.

## License

MIT License. See [LICENSE](LICENSE) file for details.
