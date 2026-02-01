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
    yvan.networking.lan-services.enable = true;
  };
}
