# NixOS Flake Configuration Architecture

This repository maintains a fully modularized NixOS configuration optimized for a user-space deployment (e.g., managed via a central dotfiles repository using a tool like GNU Stow). By decoupling machine realities from software profiles, this configuration ensures complete reproducibility, cleaner version tracking, and seamless multi-host extensibility.

## 📂 Repository File Structure

```text
📁 .
├── 📄 README.md
├── 📄 .gitignore
├── ❄️ flake.lock
├── ❄️ flake.nix
│
├── 📁 dotfiles
│   ├── 📁 direnv/
│   │   └── 📁 .config/
│   │       └── 📁 direnv/
│   │           └── 📄 direnv.toml
│   │
│   ├── 📁 doom/
│   │   └── 📁 .config/
│   │       └── 📁 doom/
│   │           ├── 📄 config.el
│   │           ├── 📄 init.el
│   │           └── 📄 packages.el
│   │
│   ├── 📁 wezterm/
│   │   └── 📁 .config/
│   │       └── 📁 wezterm/
│   │           └── 📄 wezterm.lua
│   │
│   └── 📁 zsh/
│       └── 📄 .zshrc
│ 
├── 📁 archived
│   ├── ❄️ configuration.nix
│   └── ❄️ hardware-configuration.nix
│
├── 📁 hosts
│   └── 📁 nixhp
│       ├── ❄️ default.nix
│       └── ❄️ hardware-configuration.nix
│
└── 📁 modules
    ├── 📁 core
    │   └── ❄️ default.nix
    ├── 📁 desktop
    │   └── ❄️ gnome.nix
    ├── 📁 programs
    │   ├── ❄️ dev-tools.nix
    │   └── ❄️ system-packages.nix
    └── 📁 users
        └── ❄️ gdj.nix

```
