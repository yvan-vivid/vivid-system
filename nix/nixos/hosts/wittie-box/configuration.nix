# Yvan Vivid - 'after-velazquez' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 13000;
        to = 13999;
      }
    ];

    allowedTCPPorts = [8096 8020];
    allowedUDPPorts = [7359];
  };

  yvan = {
    name = "wittie-box";
    primary = "yvan";

    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
    };

    environments = {
      runtime.enable = true;
      graphical = {
        sway.enable = false;
        apps.enable = false;
      };
    };
  };
}
