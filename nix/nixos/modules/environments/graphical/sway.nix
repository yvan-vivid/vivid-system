# Yvan Vivid - Sway Desktop Environment
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.environments.graphical.sway;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.environments.graphical.sway = {
    enable = mkEnableOption "Enable Sway DE";
  };

  config = mkIf cfg.enable {
    # Comprehensive xdg portal configuration for screen sharing support
    # Fixes Zoom and other apps that need portals on Wayland/Sway
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        # Add both wlr and gtk portals for maximum compatibility
        # gtk portal serves as fallback for apps that don't support wlr directly
        extraPortals = [ 
          pkgs.xdg-desktop-portal-wlr 
          pkgs.xdg-desktop-portal-gtk
        ];
        configPackages = [ 
          pkgs.xdg-desktop-portal-wlr 
          pkgs.xdg-desktop-portal-gtk
        ];
      };
      sounds.enable = true;
      mime.enable = true;
    };

    # Ensure portal files are linked where apps expect them
    # This fixes apps like Zoom that look in /usr/share/xdg-desktop-portal/
    environment.pathsToLink = [ 
      "/share/xdg-desktop-portal" 
      "/share/applications"
      "/share/dbus-1"
    ];

    # Explicitly install the base portal package and GTK portal
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal      # Base portal infrastructure
      xdg-desktop-portal-gtk  # GTK fallback portal
      xdg-desktop-portal-wlr  # WLR portal for Sway
    ];

    # Create portal configuration for Sway
    # This tells portals to prefer wlr but fall back to gtk
    environment.etc."xdg/xdg-desktop-portal/sway-portals.conf".text = ''
      [preferred]
      default=wlr
      org.freedesktop.impl.portal.FileChooser=gtk
      org.freedesktop.impl.portal.AppChooser=gtk
    '';

    hardware.brillo.enable = true;

    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [
        # Sway extras
        swaybg
        swaylock
        swayidle
        xwayland
        i3status-rust

        # Launch/Notification
        mako
        wofi
        avizo

        # A/V Settings
        pavucontrol
        kanshi
        redshift
        qjackctl
        pamixer

        # Utilities
        slurp
        grim
        wl-clipboard
        wev
        wl-screenrec  # Screen recording utility for testing

        # DE Apps
        alacritty
        gparted
        mpv

        # Other
        xdg-utils
        libnotify
      ];
    };
  };
}
