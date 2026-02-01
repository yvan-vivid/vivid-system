# Yvan Vivid - Fonts
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.media.fonts;
in {
  options.yvan.media.fonts = {
    enable = mkEnableOption "Font management";
  };

  config = mkIf cfg.enable {
    fonts = {
      fontDir.enable = true;
      fontconfig.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        # Should I change these fonts?
        corefonts
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.fira-code
        nerd-fonts.open-dyslexic
        google-fonts
      ];
      fontconfig = {
        defaultFonts = {
          sansSerif = ["Ubuntu"];
          monospace = ["DejaVuSansM Nerd Font Mono"];
        };
      };
    };
  };
}
