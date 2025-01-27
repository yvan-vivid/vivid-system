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
    cfg.enable = mkEnableOption "Server setup";
  };

  config = mkIf cfg.enable {
    # Server specific options
  };
}
