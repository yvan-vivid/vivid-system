# Yvan Vivid - Fonts
# TODO: Clean up and create options
{pkgs, ...}: let
  nerdfontsUsed = [
    "DejaVuSansMono"
    #"FantasqueSansMono"
    "FiraCode"
    #"Iosevka"
    "OpenDyslexic"
  ];
in {
  # Overrides
  nixpkgs.config.packageOverrides = pkgs: {
    nerdfonts = pkgs.nerdfonts.override {fonts = nerdfontsUsed;};
  };

  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      # Should I change these fonts?
      corefonts
      nerdfonts
      google-fonts
      #helvetica-neue-lt-std
      #ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Ubuntu"];
        monospace = ["DejaVuSansM Nerd Font Mono"];
      };
    };
  };
}
