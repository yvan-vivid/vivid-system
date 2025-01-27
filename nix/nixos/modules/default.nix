{
  config,
  lib,
  ...
}: let
  cfg = config.yvan;
  inherit (lib) mkOption types;
in {
  imports = [
    ./core
    ./development
    ./environments
    ./machines
    ./media
    ./services
  ];

  options = {
    yvan.name = mkOption {
      description = "System name";
      type = types.str;
    };

    yvan.primary = mkOption {
      description = "Primary user";
      type = types.str;
    };
  };

  config = {
    networking.hostName = cfg.name;
    yvan.users.power-user.primary = cfg.primary;
  };
}
