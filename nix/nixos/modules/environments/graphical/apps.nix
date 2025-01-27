{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.environments.graphical.apps;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.environments.graphical.apps = {
    enable = mkEnableOption "Add graphical apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.edge; [
      # browsers
      firefox-bin

      # Comms
      zoom-us
    ];
  };
}
