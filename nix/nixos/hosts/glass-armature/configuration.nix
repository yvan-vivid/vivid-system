# Yvan Vivid - 'glass-armature' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
    inputs.nixos-hardware.nixosModules.common-hidpi
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # boot.kernelParams = [];

  services = {
    fwupd.enable = true;
  };

  yvan = {
    name = "glass-armature";
    primary = "hexxiiiz";

    machine.server.enable = true;
    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
    };

    media = {
      rocm.enable = true;
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
