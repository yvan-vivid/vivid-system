{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.yvan.users;
in {
  options.yvan.users = {
    power-user = {
      primary = mkOption {
        description = "Primary power user";
        type = types.str;
      };

      groups = mkOption {
        description = "Extra groups for power users";
        type = with types; listOf str;
        default = [];
      };
    };
  };

  config = let
    extraGroups =
      [
        "video"
        "input"
        "wheel"
        "fuse"
        "sway"
      ]
      ++ cfg.power-user.groups;
    primary = cfg.power-user.primary;
    powerUser = {
      inherit extraGroups;
      isNormalUser = true;
      createHome = true;
      uid = 1000;
      useDefaultShell = true;
    };
  in {
    users = {
      defaultUserShell = pkgs.zsh;
      extraUsers = {"${primary}" = powerUser;};
    };
    nix.settings.trusted-users = ["root" primary];
  };
}
