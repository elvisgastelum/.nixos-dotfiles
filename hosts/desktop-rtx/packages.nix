{pkgs, ...}: let
  inherit (pkgs) lib;

  optionalPackage = name:
    lib.optional (builtins.hasAttr name pkgs) (builtins.getAttr name pkgs);
in
  (with pkgs; [
    age
    alacritty
    apple-cursor
    bat
    brightnessctl
    btop
    chromium
    curl
    dunst
    eza
    fd
    ffmpeg
    fastfetch
    fcitx5
    foot
    fzf
    git
    gnome-calculator
    gnumake
    google-chrome
    grim
    hypridle
    hyprlauncher
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    hyprsunset
    jq
		tuxedo
    keyutils
    kitty
    lazygit
    libnotify
    libpulseaudio
    mako
    mesa-demos
    nautilus
    neovim
    networkmanagerapplet
    nodejs_22
    obs-studio
    opencode
    pamixer
    pavucontrol
    pciutils
    playerctl
    ripgrep
    ruby
    satty
    shfmt
    slurp
    sops
    steam
    tmux
    unzip
    vim
    vulkan-tools
    waybar
    wget
    wireplumber
    wl-clipboard
    wofi
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-terminal-exec
    xdg-utils
    xsel
    yq
    zoxide
    zsh
  ])
  ++ optionalPackage "bluetui"
  ++ optionalPackage "brave"
  ++ optionalPackage "elephant"
  ++ optionalPackage "ghostty"
  ++ optionalPackage "gpu-screen-recorder"
  ++ optionalPackage "hyprland-preview-share-picker"
  ++ optionalPackage "impala"
  ++ optionalPackage "polkit_gnome"
  ++ optionalPackage "power-profiles-daemon"
  ++ optionalPackage "prettier"
  ++ optionalPackage "ratune"
  ++ optionalPackage "swayosd"
  ++ optionalPackage "uwsm"
  ++ optionalPackage "walker"
  ++ optionalPackage "wiremix"
# Zap is bootstrapped in zsh defaults (plugins.zsh), not packaged in nixpkgs
