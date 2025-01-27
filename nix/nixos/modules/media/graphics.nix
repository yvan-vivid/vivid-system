{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # These are all for compute
      rocmPackages.clr.icd
      intel-compute-runtime

      # This is for amd vulkan support
      amdvlk

      # Primary intel driver
      intel-media-driver
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  environment.systemPackages = [pkgs.libva-utils];
}
