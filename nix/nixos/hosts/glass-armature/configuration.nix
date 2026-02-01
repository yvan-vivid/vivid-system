# Yvan Vivid - 'glass-armature' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    ./hardware-configuration.nix
    framework-desktop-amd-ai-max-300-series
    common-hidpi
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  services = {
    fwupd.enable = true;
  };

  yvan = {
    name = "glass-armature";
    primary = "hexxiiiz";

    machine = {
      server.enable = true;
      desktop.enable = true;
    };
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
