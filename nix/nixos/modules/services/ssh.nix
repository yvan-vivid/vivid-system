{
  config,
  lib,
  ...
}: let
  cfg = config.yvan.services.ssh;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.services.ssh = {
    enable = mkEnableOption "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
  };
}
