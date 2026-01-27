{...}: {
  perSystem = {pkgs, ...}: {
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
        discord
        telegram-desktop

        # browsers
        firefox-bin
        chromium

        # emulation
        gzdoom
        higan
        zsnes
      ];
    };
  };
}
