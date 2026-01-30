{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.yvan.networking;
in {
  options.yvan.networking.lan-services = {
    enable = mkEnableOption "LAN services (ports 13000-13999)";
  };

  config = mkMerge [
    {
      networking = {
        networkmanager.enable = true;
        iproute2.enable = true;
        useDHCP = false;
        hosts = {
          "127.0.0.1" = ["localhost.localdomain" "localhost"];
          "192.168.68.66" = ["red-arrow.localdomain" "red-arrow"];
          "192.168.68.72" = ["after-velazquez.localdomain" "after-velazquez"];
          "192.168.68.67" = ["wittie-box.localdomain" "wittie-box"];
          "192.168.69.62" = ["yvone.localdomain" "yvone"];
          "192.168.68.59" = ["mini.localdomain" "mini"];
          "192.168.68.56" = ["packard-mill.localdomain" "packard-mill"];
        };

        firewall = {
          enable = true;
        };
      };

      services.resolved.enable = lib.mkDefault true;

      yvan.users.power-user.groups = [
        "network"
        "networkmanager"
      ];

      environment.systemPackages = with pkgs; [
        curl
        wget
        nmap
        netcat
        websocat
        iftop
        wireguard-tools
      ];
    }
    (mkIf cfg.lan-services.enable {
      networking.firewall.allowedTCPPortRanges = [
        {
          from = 13000;
          to = 13999;
        }
      ];
    })
  ];
}
