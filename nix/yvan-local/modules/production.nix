{...}: {
  perSystem = {pkgs, ...}: {
    packages.yvan-production = pkgs.buildEnv {
      name = "yvan-production";
      paths = with pkgs; [
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
    };
  };
}

