{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.services.docker;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.services.docker = {
    enable = mkEnableOption "Enable docker";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;
    };
    yvan.users.power-user.groups = [
      "docker"
    ];
    environment.systemPackages = with pkgs; [
      ctop
    ];
  };
}
