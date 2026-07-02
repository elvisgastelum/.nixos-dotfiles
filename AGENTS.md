# Repository Guidelines

## Scope
- Flake-based NixOS + Home Manager dotfiles for one host: `desktop-rtx` on `x86_64-linux`.
- Root entrypoint is `flake.nix`; it exposes only `nixosConfigurations.desktop-rtx` and imports `hosts/desktop-rtx/configuration.nix` plus Home Manager user `dev` from `home/dev/home.nix`.

## Commands
- Check first: `nix flake check /home/dev/.nixos-dotfiles`
- Before applying host changes: `sudo nixos-rebuild dry-build --flake /home/dev/.nixos-dotfiles#desktop-rtx`
- Apply host config: `sudo nixos-rebuild switch --flake /home/dev/.nixos-dotfiles#desktop-rtx`
- New hardware only: `sudo nixos-generate-config --show-hardware-config > hosts/desktop-rtx/hardware-configuration.nix`, then dry-build before switching.
- No repo-local test/lint/format runner was found; use the Nix checks above as the source of truth.

## Layout and generated links
- `hosts/desktop-rtx/configuration.nix` is the NixOS host module; `hosts/desktop-rtx/packages.nix` supplies `environment.systemPackages`.
- `home/dev/home.nix` wires Home Manager: XDG config directories from `home/dev/config/*`, scripts from `home/dev/bin/*`, desktop entries, man pages, and `.claude`.
- `home/dev/bin/dotfiles` is the main desktop helper CLI used by Hyprland/keybindings and generated desktop entries.
- `home/dev/config/hypr/hyprland.conf` sources repo defaults before local overrides; avoid breaking `dotfiles` calls from bindings.
- Neovim starts from `home/dev/config/nvim/init.lua`; the loader supports the `dev` and `stable` profiles.

## Repo-specific gotchas
- `home-manager.backupFileExtension = "backup"`; Home Manager collisions may leave `*.backup` files.
- UWSM owns the Hyprland session: keep `wayland.windowManager.hyprland.systemd.enable = false` unless changing the session model.
- `home.activation.createMutableZshFiles` only copies zsh scaffold files when missing; the installed zsh files are intentionally mutable.
- Keep `system.stateVersion` and `home.stateVersion` pinned at `26.05` unless intentionally migrating state.
- Wi-Fi secrets are not tracked; NetworkManager stores connections under `/etc/NetworkManager/system-connections/`.

## OpenCode/agent config in this repo
- Repo-local OpenCode files live under `home/dev/config/opencode/`; its config loads `AGENTS.md` plus `instructions/cost-aware-delegation.md` after Home Manager links it into `~/.config/opencode`.
- The OpenCode config is agent-first: default `CodePlanner`, built-in `plan/build/general/explore` disabled, global edits denied, bash asks.
- After changing OpenCode config, agents, skills, instructions, plugins, MCP servers, or permissions, tell the user to restart OpenCode because those files are not hot-reloaded.
