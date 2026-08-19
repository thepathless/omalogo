# OmaLogo (`omalogo`)

Omarchy status bar logo and app menu plugin featuring:
- **Left-Click**: Toggle the Omarchy App Menu (`omarchy.menu`).
- **Right-Click**: Launch terminal (`xdg-terminal-exec`).
- **Middle-Click**: Open the Omarchy-styled Distro Logo Picker popup.
- **Scroll (Wheel)**: Switch Hyprland workspaces smoothly (Niri-style).

## Features

- **Distro Logo Picker**: Select from 22 Linux distro icons (Omarchy, Arch, Debian, Fedora, Ubuntu, NixOS, Gentoo, Void, Alpine, openSUSE, Manjaro, Mint, EndeavourOS, Pop!_OS, Kali, Artix, FreeBSD, Red Hat, Rocky, AlmaLinux, CentOS, Tux).
- **Persistent Selection**: Your chosen logo is saved into `~/.config/omarchy/shell.json`.
- **Searchable Distro List**: Filter distros by name or keyword.
- **Workspace Navigation**: Scroll wheel on the logo jumps between workspaces forward and backward.

## Installation

Symlink into `~/.config/omarchy/plugins/omalogo`:
```bash
ln -s ~/Projects/omamenu ~/.config/omarchy/plugins/omalogo
```

Add or replace in `~/.config/omarchy/shell.json` in `bar.layout.left`:
```json
{
  "id": "omalogo",
  "distro": "arch"
}
```
