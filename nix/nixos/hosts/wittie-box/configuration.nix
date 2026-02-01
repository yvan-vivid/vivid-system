# Yvan Vivid - 'wittie-box' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-hidpi
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Enable thermald for Intel thermal management
  services.thermald.enable = true;

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
