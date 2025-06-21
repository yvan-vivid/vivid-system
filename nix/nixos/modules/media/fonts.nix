# Yvan Vivid - Fonts
# TODO: Clean up and create options
{pkgs, ...}: {
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
