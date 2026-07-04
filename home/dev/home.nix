{
  config,
  lib,
  pkgs,
  ...
}:
let
  configDirs = [
    "alacritty"
    "btop"
    "dotfiles"
    "emacs"
    "fastfetch"
    "foot"
    "ghostty"
    "git"
    "hypr"
    "hyprland-preview-share-picker"
    "kitty"
    "lazygit"
    "mako"
    "nvim"
    "obs-studio"
    "opencode"
    "ratune"
    "swayosd"
    "tmux"
    "uwsm"
    "walker"
    "wallpaper"
    "waybar"
  ];

  configFiles = {
    "chromium-flags.conf" = ./config/chromium-flags.conf;
    "xdg-terminals.list" = ./config/xdg-terminals.list;
    "zsh/default" = ./config/zsh/default;
  };

  binFiles = builtins.attrNames (builtins.readDir ./bin);
  desktopFiles = builtins.attrNames (builtins.readDir ./share-applications);
  manFiles = builtins.attrNames (builtins.readDir ./man/man1);

  optionalPackage = name: lib.optional (builtins.hasAttr name pkgs) (builtins.getAttr name pkgs);

  homeDir = config.home.homeDirectory;
  # Intentionally outside the Nix store so selected app configs stay live-editable;
  # this checkout is expected to live at the host-local dotfiles path below.
  dotfilesDir = "${homeDir}/.nixos-dotfiles";
in
{
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  xdg.enable = true;

  # UWSM manages the Hyprland systemd session; avoid Home Manager's integration conflict.
  wayland.windowManager.hyprland.systemd.enable = false;

  home.packages =
    with pkgs;
    [
      bat
      btop
      eza
      fd
      fzf
      jq
      nodejs_22
      nixd
      nixfmt
      ripgrep
      tmux
      python313Packages.terminaltexteffects
      unzip
      yq
      zoxide
    ]
    ++ optionalPackage "bluetui"
    ++ optionalPackage "impala"
    ++ optionalPackage "prettier"
    ++ optionalPackage "wiremix";

  home.sessionVariables = {
    DOTFILES_SOURCE_DIR = dotfilesDir;
    ZDOTDIR = "${homeDir}/.config/zsh";
    ZSH_CONFIG_HOME = "${homeDir}/.config/zsh";
  };

  xdg.configFile =
    lib.genAttrs (builtins.filter (name: name != "nvim") configDirs) (name: {
      source = ./config + "/${name}";
      recursive = true;
    })
    // {
      nvim.source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/home/dev/config/nvim";
    }
    // lib.mapAttrs (_: source: { inherit source; }) configFiles;

  home.file =
    lib.genAttrs (map (name: ".local/bin/${name}") binFiles) (target: {
      source = ./bin + "/${builtins.baseNameOf target}";
      executable = true;
    })
    // lib.genAttrs (map (name: ".local/share/applications/${name}") desktopFiles) (target: {
      source = ./share-applications + "/${builtins.baseNameOf target}";
    })
    // lib.genAttrs (map (name: ".local/share/man/man1/${name}") manFiles) (target: {
      source = ./man/man1 + "/${builtins.baseNameOf target}";
    })
    // {
      ".claude" = {
        source = ./claude;
        recursive = true;
      };
    };

  home.activation.createMutableZshFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    zsh_config_dir="${homeDir}/.config/zsh"

    run mkdir -p "$zsh_config_dir"

    copy_if_missing() {
      source_file="$1"
      target_file="$2"
      mode="$3"

      if [ ! -e "$target_file" ]; then
        run install -m "$mode" "$source_file" "$target_file"
      fi
    }

    copy_if_missing ${./zshenv} "${homeDir}/.zshenv" 0644
    copy_if_missing ${./scaffold/zsh/.zshrc} "$zsh_config_dir/.zshrc" 0644
    copy_if_missing ${./scaffold/zsh/.zprofile} "$zsh_config_dir/.zprofile" 0644
    copy_if_missing ${./scaffold/zsh/.env} "$zsh_config_dir/.env" 0600
    copy_if_missing ${./scaffold/zsh/aliases.zsh} "$zsh_config_dir/aliases.zsh" 0644
    copy_if_missing ${./scaffold/zsh/completion.zsh} "$zsh_config_dir/completion.zsh" 0644
    copy_if_missing ${./scaffold/zsh/env.zsh} "$zsh_config_dir/env.zsh" 0644
    copy_if_missing ${./scaffold/zsh/functions.zsh} "$zsh_config_dir/functions.zsh" 0644
    copy_if_missing ${./scaffold/zsh/plugins.zsh} "$zsh_config_dir/plugins.zsh" 0644
    copy_if_missing ${./scaffold/zsh/rc.zsh} "$zsh_config_dir/rc.zsh" 0644
  '';

  programs.hunk = {
    enable = true;
    enableGitIntegration = false;

    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };

  programs.home-manager.enable = true;

  # This value should stay at the Home Manager release used for the first install.
  home.stateVersion = "26.05";
}
