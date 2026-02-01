# Yvan Vivid - ROCm Compute Support for AMD GPUs
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.media.rocm;
in {
  options.yvan.media.rocm = {
    enable = mkEnableOption "ROCm compute support for AMD GPUs";
  };

  config = mkIf cfg.enable {
    # ROCm packages for AMD GPU compute
    hardware.graphics.extraPackages = with pkgs.rocmPackages; [
      clr
      clr.icd
      rocm-runtime
      rocminfo
    ];

    # ROCm utility tools
    environment.systemPackages = with pkgs.rocmPackages; [
      rocminfo
      rocm-smi
    ];
  };
}
