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

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Non-standard efi boot mount
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

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
