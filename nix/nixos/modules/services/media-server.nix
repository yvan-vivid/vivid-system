{
  config,
  lib,
  ...
}: let
  cfg = config.yvan.services.media-server;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.services.media-server = {
    enable = mkEnableOption "Enable media server";
  };

  config = mkIf cfg.enable {
    services.plex = {
      enable = true;
      openFirewall = true;
    };
  };
}
