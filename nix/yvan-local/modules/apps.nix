{...}: {
  perSystem = {pkgs, lib, ...}: {
    packages.yvan-apps = pkgs.buildEnv {
      name = "yvan-apps";
      paths = with pkgs; [
        # media
        beets
        sioyek
        obsidian

        # files
        sshfs-fuse

        # ai
        ollama

        # networking
        wireguard-tools
        yt-dlp
        gallery-dl

        # social networking
        # zoom-us
        signal-desktop
        telegram-desktop

        # browsers
        chromium

        # emulation
        gzdoom
        higan
      ] ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
        discord
        firefox-bin
        zsnes
      ];
    };
  };
}
