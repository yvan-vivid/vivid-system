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
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-wlr];
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
        wob

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
