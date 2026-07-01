{ config, pkgs, ... }:

{
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  home.file.".config/hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Elvis Gastelum";
      email = "elvisgastelum@outlook.com";
    };
  };
  
  programs.home-manager.enable = true;

  # This value should stay at the Home Manager release used for the first install.
  home.stateVersion = "26.05";
}
