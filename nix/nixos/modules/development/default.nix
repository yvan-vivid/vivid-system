{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.dev;
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    ./android.nix
    ./git.nix
    ./keyboard.nix
    ./web.nix
  ];

  options.yvan.dev = {
    full = mkEnableOption "Full development";
  };

  config.yvan.dev = mkIf cfg.full {
    android.enable = true;
    git.enable = true;
    keyboard.enable = true;
    web.enable = true;
  };

  # Always include these
  config.environment.systemPackages = with pkgs; [
    binutils
    gcc
    gnumake
  ];
}
