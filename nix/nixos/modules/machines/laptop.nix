# Yvan Vivid - Laptop setup
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.machine.laptop;
in {
  options.yvan.machine.laptop = {
    enable = mkEnableOption "Laptop setup";
  };

  config = mkIf cfg.enable {
    yvan.media = {
      audio.enable = true;
      fonts.enable = true;
    };

    services = {
      auto-cpufreq.enable = true;
    };
  };
}
