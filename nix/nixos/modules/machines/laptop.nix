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
    # TODO: DE + full fonts

    # Logind tweaks
    services.logind = {
      extraConfig = ''
        HandlePowerKey=suspend
        HandleLidSwitchExternalPower=ignore
      '';
    };
  };
}
