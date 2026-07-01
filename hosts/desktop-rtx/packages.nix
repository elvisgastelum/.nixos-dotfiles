{ pkgs, ... }:

with pkgs; [
  neovim
  vim
  git
  wget
  curl
  opencode
  lazygit

  # Cursor
  apple-cursor

  # Hyprland basics
  kitty
  waybar
  wofi
  hyprlauncher
  dunst
  hyprpaper
  hyprshot
  wl-clipboard
  grim
  slurp

  # File manager
  nautilus
  pavucontrol
  brightnessctl
  networkmanagerapplet

  # Browser
  chromium
  google-chrome

  # Extra
  mesa-demos
  vulkan-tools
  pciutils

  # Fast fetch
  fastfetch

  # Games
  steam
]
