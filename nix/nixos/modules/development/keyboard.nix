# Yvan Vivid - Custom keyboard development
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.dev.keyboard;
in {
  options.yvan.dev.keyboard = {
    enable = mkEnableOption "Custom keyboard development and flashing";
  };

  config = mkIf cfg.enable {
    # udev rule additions for iris keyboard
    services.udev.extraRules = ''
      ### ATmega32U4
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", TAG+="uaccess"
    '';
  };
}
