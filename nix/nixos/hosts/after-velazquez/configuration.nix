# Yvan Vivid - 'after-velazquez' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  yvan = {
    name = "after-velazquez";
    primary = "hexxiiiz";

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
