{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.services.media-server;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.services.media-server = {
    enable = mkEnableOption "Enable media server";
  };

  config = mkIf cfg.enable {
    # Jellyfin service
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    # Add jellyfin-ffmpeg for transcoding support
    environment.systemPackages = [ pkgs.jellyfin-ffmpeg ];

    # Create media group for shared media access
    users.groups.media = {};

    # Add jellyfin user to media group
    users.users.jellyfin.extraGroups = [ "media" ];

    # Add primary user to media group
    yvan.users.power-user.groups = [ "media" ];
  };
}
