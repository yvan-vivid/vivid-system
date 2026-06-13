# Yvan Vivid - android development
{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.dev.android;
in {
  options.yvan.dev.android = {
    enable = mkEnableOption "android development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.android-tools
    ];
    yvan.users.power-user.groups = [
      "adbusers"
    ];
  };
}
