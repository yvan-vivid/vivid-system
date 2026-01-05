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
    ];
  };

  environment.systemPackages = [pkgs.libva-utils];
}
