# Yvan Vivid - Git setup
{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.dev.git;
in {
  options.yvan.dev.git = {
    enable = mkEnableOption "git support";
  };

  config = mkIf cfg.enable {
    programs = {
      git.enable = true;
    };
    environment.systemPackages = with pkgs; [
      git-lfs
      gitAndTools.git-annex
      gitAndTools.git-annex-utils
      gitAndTools.git-annex-remote-rclone
      gitAndTools.git-annex-remote-googledrive
    ];
  };
}
