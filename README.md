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

This config enables NetworkManager. On a new system, connect with:

```bash
nmtui
```

Or with `nmcli`:

```bash
nmcli device wifi list
nmcli device wifi connect "SSID" --ask
```

NetworkManager stores connections outside this repository under `/etc/NetworkManager/system-connections/`.

For a fully declarative future setup, add encrypted secrets with `sops-nix` or `agenix` instead of committing plaintext credentials.

## First Bootstrap Notes

On new hardware, regenerate the host hardware config before switching:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/desktop-rtx/hardware-configuration.nix
```

Then run a dry build before switching.
