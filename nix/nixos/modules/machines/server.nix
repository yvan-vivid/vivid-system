# Yvan Vivid - Server setup
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.machine.server;
in {
  options = {
    yvan.machine.server = {
      enable = mkEnableOption "Server setup";
    };
  };

  config = mkIf cfg.enable {
    # Enable all media modules for server
    # NOTE: This may change later as server needs evolve
    yvan.media = {
      audio.enable = true;
      graphics.enable = true;
      fonts.enable = true;
    };
  };
}
