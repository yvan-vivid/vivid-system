# Yvan Vivid - Desktop setup
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.machine.desktop;
in {
  options.yvan.machine.desktop = {
    enable = mkEnableOption "Desktop setup";
  };

  config = mkIf cfg.enable {
    yvan.media = {
      audio.enable = true;
      fonts.enable = true;
    };
  };
}
