# NixOS Flake Configuration Architecture

This repository maintains a fully modularized NixOS configuration optimized for a user-space deployment (e.g., managed via a central dotfiles repository using a tool like GNU Stow). By decoupling machine realities from software profiles, this configuration ensures complete reproducibility, cleaner version tracking, and seamless multi-host extensibility.

## 📂 Repository File Structure

```text
📁 .
├── 📁 archived
│   ├── ❄️ configuration.nix
│   └── ❄️ hardware-configuration.nix
├── 📄 .gitignore
├── ❄️ flake.lock
├── ❄️ flake.nix
├── 📁 hosts
│   └── 📁 nixhp
│       ├── ❄️ default.nix
│       └── ❄️ hardware-configuration.nix
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
