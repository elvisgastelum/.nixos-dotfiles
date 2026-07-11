{ config, pkgs, ... }:

let
  startHyprland = "${pkgs.uwsm}/bin/uwsm start -e -D Hyprland -- hyprland.desktop";
  onlyUwsmHyprlandSession = pkgs.writeTextDir "share/wayland-sessions/hyprland-uwsm-only.desktop" ''
    [Desktop Entry]
    Name=Hyprland (uwsm-managed)
    Comment=Hyprland compositor managed by UWSM
    Exec=${startHyprland}
    TryExec=${pkgs.uwsm}/bin/uwsm
    DesktopNames=Hyprland
    Type=Application
  '';
  emptyXsessionsDir = pkgs.runCommand "empty-xsessions" { } ''
    mkdir -p $out/share/xsessions
  '';
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs; };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking.
  networking.hostName = "desktop-rtx";

  networking = {
    networkmanager.enable = false;
    wireless.enable = false;
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;

          ControlPortOverNL80211 = false;
        };

        Network = {
          EnableIPv6 = true;
          NameResolvingService = "systemd";
        };

        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  services.resolved.enable = true;

  # Needed by many Wi-Fi adapters
  hardware.enableRedistributableFirmware = true;

  # Set your time zone.
  time.timeZone = "America/Hermosillo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.inputMethod = {
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        kdePackages.fcitx5-qt
      ];
    };
  };

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # NVIDIA Driver.
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Wayland / Electron / Chromium helpers.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  users.users.dev = {
    isNormalUser = true;
    description = "Elvis Gastelum";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "input"
    ];
    packages = [ ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    config.common = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
    };
  };

  # Audio.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Polkit agent support.
  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Login manager: simple text greeter.
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions ${onlyUwsmHyprlandSession}/share/wayland-sessions --xsessions ${emptyXsessionsDir}/share/xsessions";
        user = "greeter";
      };
    };
  };

  security.sudo.wheelNeedsPassword = true;

  services.openssh.enable = true;

  # This value should stay at the release used for the first install.
  system.stateVersion = "26.05";
}
