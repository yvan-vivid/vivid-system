{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Primary intel driver
      intel-media-driver

      # Intel compute
      intel-compute-runtime

      # Rocm compute
      rocmPackages.clr
      rocmPackages.clr.icd
      rocmPackages.rocm-runtime
      rocmPackages.rocminfo

      # This is for amd vulkan support
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  environment.systemPackages = [pkgs.libva-utils];
}
