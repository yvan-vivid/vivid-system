# Yvan Vivid - 'wittie-box' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    ./hardware-configuration.nix
    common-cpu-intel
    common-gpu-intel
    common-pc
    common-hidpi
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

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
    };
  };
}
