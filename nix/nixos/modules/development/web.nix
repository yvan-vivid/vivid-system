# Yvan Vivid - Web Development
{
  config,
  lib,
  ...
}: let
  cfg = config.yvan.dev.web;
  inherit (lib) mkEnableOption mkIf;
in {
  options.yvan.dev.web = {
    enable = mkEnableOption "Web development tweaks";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      # TODO: Decide on firewall holes
      allowedTCPPorts = [];
      allowedTCPPortRanges = [];
    };
  };
}
