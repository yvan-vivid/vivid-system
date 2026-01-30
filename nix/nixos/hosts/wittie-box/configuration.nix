# Yvan Vivid - 'wittie-box' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  yvan = {
    name = "wittie-box";
    primary = "yvan";

    machine.server.enable = true;
    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
    };

    environments = {
      runtime.enable = true;
      graphical = {
        sway.enable = true;
        apps.enable = true;
      };
    };
  };
}
