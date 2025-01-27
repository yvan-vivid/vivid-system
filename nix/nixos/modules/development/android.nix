# Yvan Vivid - android development
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.dev.android;
in {
  options.yvan.dev.android = {
    enable = mkEnableOption "android development";
  };

  config = mkIf cfg.enable {
    programs = {
      adb.enable = true;
    };

    yvan.users.power-user.groups = [
      "adbusers"
    ];
  };
}
