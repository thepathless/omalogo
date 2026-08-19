# OmaLogo

A modern, highly customizable application menu launcher and distribution branding widget for the Omarchy status bar.

## Features

- **App Menu Launch**: Left-click to open the native Omarchy command and application menu.
- **Terminal Shortcut**: Right-click to immediately spawn the default terminal emulator.
- **Distribution Branding**: Middle-click to choose from 22 curated distribution logos with real-time search filtering.
- **Workspace Navigation**: Scroll over the widget to cycle through active workspaces forward and backward.
- **State Persistence**: Selected branding persists across reboots and shell reloads in `~/.config/omarchy/shell.json`.

## Interactions

| Action | Function |
| :--- | :--- |
| **Left Click** | Open Omarchy Application Menu |
| **Right Click** | Launch Terminal |
| **Middle Click** | Open Distribution Logo Picker |
| **Mouse Scroll Up** | Previous Workspace (`hl.dsp.focus({ workspace = "e-1" })`) |
| **Mouse Scroll Down** | Next Workspace (`hl.dsp.focus({ workspace = "e+1" })`) |

## Installation

Symlink into the Omarchy plugins directory:

```bash
ln -s ~/Projects/omamenu ~/.config/omarchy/plugins/omalogo
```

Add or replace `omarchy.menu` in `~/.config/omarchy/shell.json` under `bar.layout.left`:

```json
{
  "id": "omalogo",
  "distro": "arch"
}
```
