# Repository Guidelines

## Scope
- Flake-based NixOS + Home Manager dotfiles for one host: `desktop-rtx` on `x86_64-linux`.
- Root flake exposes only `nixosConfigurations.desktop-rtx`.
- It imports `hosts/desktop-rtx/configuration.nix` and Home Manager user `dev`.
- nixpkgs is pinned to unstable.

## Commands
- Check first: `nix flake check /home/dev/.nixos-dotfiles`
- Dry-build host changes: `sudo nixos-rebuild dry-build --flake /home/dev/.nixos-dotfiles#desktop-rtx`
- Apply host config: `sudo nixos-rebuild switch --flake /home/dev/.nixos-dotfiles#desktop-rtx`
- New hardware only: `sudo nixos-generate-config --show-hardware-config > hosts/desktop-rtx/hardware-configuration.nix`
- After hardware generation, dry-build before switching.

## Layout
- `hosts/desktop-rtx/configuration.nix` is the NixOS host module.
- `hosts/desktop-rtx/packages.nix` feeds `environment.systemPackages`.
- `home/dev/home.nix` wires Home Manager.
- `home/dev/config/*` provides XDG config dirs.
- `home/dev/bin/*` provides scripts.
- `home/dev/share-applications/*` provides desktop entries.
- `home/dev/man/man1/*` provides man pages.
- `home/dev/claude` is linked as `.claude`.

## Runtime / behavior notes
- Many Home Manager links are out-of-store symlinks and live-editable.
- `home/dev/bin/dotfiles` is the central desktop helper CLI used by Hyprland keybindings and generated desktop entries.
- Hyprland entrypoint: `home/dev/config/hypr/hyprland.conf`.
- Hyprland sources repo defaults before local overrides.
- UWSM owns the Hyprland session; keep `wayland.windowManager.hyprland.systemd.enable = false` unless changing the session model.
- NetworkManager and kernel wireless management are disabled; Wi-Fi uses iwd directly plus resolved.
- `home.activation.createMutableZshFiles` copies zsh scaffold files only when missing; installed zsh files are intentionally mutable.
- Neovim starts from `home/dev/config/nvim/init.lua` and supports `dev` and `stable` profiles.
- Keep `system.stateVersion` and `home.stateVersion` pinned at `26.05` unless intentionally migrating state.

## OpenCode config
- OpenCode files live under `home/dev/config/opencode/`.
- Default agent is `CodePlanner`.
- Built-in `plan/build/general/explore` are disabled.
- Global edits are denied; bash asks.
- Subagents must not delegate.
- Restart OpenCode after changing config, agents, skills, plugins, MCP servers, or permissions.

## Claude Code config
- Claude Code config lives under `home/dev/claude` and is linked as `.claude`.
- It uses the default code-planner, command sets, and MCP servers including Context7 and local NixOS.
- Restart Claude Code after config changes if needed.
