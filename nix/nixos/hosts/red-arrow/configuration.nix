# Yvan Vivid - 'red-arrow' NixOS config
{
  lib,
  pkgs,
  ...
}:
# inherit (lib);
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_17;

    kernelParams = [
      # TODO: Do I need this?
      # "mem_sleep_default=deep"
    ];
  };

  # Non-standard efi boot mount
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  # For the ambient light sensor
  hardware.sensor.iio.enable = true;

  yvan = {
    name = "red-arrow";
    primary = "hexxiiiz";

    machine.laptop.enable = true;
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
