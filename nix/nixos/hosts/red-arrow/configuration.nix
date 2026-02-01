# Yvan Vivid - 'red-arrow' NixOS config
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    ./hardware-configuration.nix
    common-cpu-intel
    common-gpu-intel
    common-pc-laptop
    common-pc-laptop-ssd
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;

    kernelParams = [
      # Fix screen tearing on Surface Laptop Go
      "i915.enable_psr=0"
      # Enable S0ix "Modern Standby" for better sleep/suspend
      "mem_sleep_default=deep"
    ];
  };

  # Non-standard efi boot mount
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  hardware.sensor.iio.enable = true;
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
