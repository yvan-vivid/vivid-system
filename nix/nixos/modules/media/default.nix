{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.yvan.media = {
    audio.enable = mkEnableOption "Audio support";
    graphics.enable = mkEnableOption "Graphics support";
    fonts.enable = mkEnableOption "Font management";
  };

  imports = [
    ./audio.nix
    ./graphics.nix
    ./fonts.nix
    ./rocm.nix
  ];
}
