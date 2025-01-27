# Yvan Vivid - EFI boot setup
# Here I'm just using systemd-boot since I don't anticipate needing GRUB
# If I do end up needing GRUB again, I will make this a module with options
#
# There are some kernel module options here that I'm not sure I need
{pkgs, ...}: {
  config = {
    # TODO: Do I need this?
    # boot.initrd.kernelModules = ["i915"];
    # boot.kernelModules = ["tun"];

    # Boot specifics
    boot.loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    # Might be necessary for amd startup
    # boot.initrd.kernelModules = [ "amdgpu" ];
    # boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

    # TODO: Should we be updating microcodes?
    # hardware.cpu.intel.updateMicrocode = true;
    # hardware.cpu.amd.updateMicrocode = true;

    # Console setup
    console = {
      packages = [pkgs.terminus_font];
      keyMap = "us";

      # This should choose the appropriate font for the resolution
      font = null;

      # If we need to force this
      # font = "ter-i16b"; # NDPI
      # font = "ter-i32b"; # HDPI
    };
  };
}
