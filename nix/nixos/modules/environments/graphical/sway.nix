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
    programs.xwayland.enable = true;

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
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

    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
      "/share/dbus-1"
    ];

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal # Base portal infrastructure
      xdg-desktop-portal-gtk # GTK fallback portal
      xdg-desktop-portal-wlr # WLR portal for Sway
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

      # Enable XWayland support for X11 applications
      xwayland.enable = true;

      # Enable GTK features for better app compatibility
      wrapperFeatures.gtk = true;

      # Set up session environment variables for Wayland and X11 apps
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=sway
        export QT_QPA_PLATFORM=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export SDL_VIDEODRIVER=wayland
        export NIXOS_OZONE_WL=1

        # Import environment into systemd for services
        systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP DISPLAY WAYLAND_DISPLAY
      '';

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
        wl-screenrec # Screen recording utility for testing

        # DE Apps
        alacritty
        gparted
        mpv

        # Other
        xdg-utils
        libnotify
        qt5.qtwayland # Qt5 Wayland platform plugin
        qt6.qtwayland # Qt6 Wayland platform plugin
      ];
    };
  };
}
