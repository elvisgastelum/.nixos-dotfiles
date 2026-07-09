# NixOS Dotfiles

Flake-based NixOS and Home Manager configuration.

## Hosts

- `desktop-rtx`

## Layout

```text
.
├── flake.nix
├── hosts
│   └── desktop-rtx
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── packages.nix
└── home
    └── dev
        ├── home.nix
        └── config
            └── hypr
                └── hyprland.lua
```

## Build

Check the flake:

```bash
nix flake check /home/dev/.nixos-dotfiles
```

Dry-build the host:

```bash
sudo nixos-rebuild dry-build --flake /home/dev/.nixos-dotfiles#desktop-rtx
```

Switch to the host config:

```bash
sudo nixos-rebuild switch --flake /home/dev/.nixos-dotfiles#desktop-rtx
```

## Wi-Fi

Wi-Fi credentials are intentionally not tracked in git.

This host does **not** use NetworkManager. It uses `iwd` directly, and the Hyprland session autostarts a polkit agent.

Use `dotfiles control wifi` or press `Super + Ctrl + W` to open the Wi-Fi control panel:

```bash
dotfiles control wifi
```

This launches **Impala**, the Wi-Fi TUI. No `sudo` is needed for normal connections; if a system prompt appears, approve it via polkit.

NetworkManager-style `nmtui`/`nmcli` are not the configured path here.

## First Bootstrap Notes

On new hardware, regenerate the host hardware config before switching:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/desktop-rtx/hardware-configuration.nix
```

Then run a dry build before switching.
