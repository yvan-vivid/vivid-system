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
    # Expanded xdg portal configuration for screen sharing support
    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        # Add the actual portal implementation package
        extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
        configPackages = [ pkgs.xdg-desktop-portal-wlr ];
      };
      sounds.enable = true;
      mime.enable = true;
    };

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
