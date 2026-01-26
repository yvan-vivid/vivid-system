{pkgs}:
with pkgs;
  buildEnv {
    name = "yvan-production";
    paths = [
      # audio
      audacity
      # ardour
      mediainfo
      lame
      # zrythm

      # image
      gimp
      shotwell
      imagemagick
      inkscape
      # darktable

      # video
      # olive-editor
      obs-studio

      # multimedia
      blender
    ];
  }

