# Yvan Vivid - 'red-arrow' NixOS config
{
  lib,
  pkgs,
  inputs,
  ...
}:
# inherit (lib);
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;

    # Surface Laptop Go specific tweaks
    kernelParams = [
      # Fix screen tearing on Surface Laptop Go
      "i915.enable_psr=0"
      # Enable S0ix "Modern Standby" for better sleep/suspend
      "mem_sleep_default=deep"
    ];
  };

  # Non-standard efi boot mount
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  # For the ambient light sensor
  hardware.sensor.iio.enable = true;

  # Enable thermald for Intel thermal management
  services.thermald.enable = true;

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
