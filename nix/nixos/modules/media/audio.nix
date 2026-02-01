# Yvan Vivid - Audio/Sound
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yvan.media.audio;
in {
  options.yvan.media.audio = {
    enable = mkEnableOption "Audio support";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;

      # Support for legacy adapters
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    # This is for apps to get realtime priorities
    security.rtkit.enable = true;

    # Special limits for audio production
    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "800000";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "95";
      }
    ];

    yvan.users.power-user.groups = [
      "audio"
      "jackaudio" # media control
    ];
  };
}
