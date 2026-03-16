# Yvan Vivid - EFI boot setup
# Here I'm just using systemd-boot since I don't anticipate needing GRUB
# If I do end up needing GRUB again, I will make this a module with options
{
  pkgs,
  lib,
  ...
}: {
  options = {
  };

  config = {
    # Default to LTS kernel (6.12), hosts can override
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_6_12;

    # Boot specifics
    boot.loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    # Console setup
    console = {
      packages = [pkgs.terminus_font];
      keyMap = "us";
      font = null;
    };
  };
}
