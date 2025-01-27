# Yvan Vivid - Runtime environment
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yvan.environments.runtime;
  inherit (lib) mkIf mkEnableOption;
in {
  options.yvan.environments.runtime = {
    enable = mkEnableOption "Add runtime environment additions";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Language Runtimes
      python313
      nodejs

      # Run with nix wrapper
      nix-ld
    ];

    # Appimage Support
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
