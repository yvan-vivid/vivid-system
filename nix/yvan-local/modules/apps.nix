{pkgs}:
with pkgs;
  buildEnv {
    name = "yvan-apps";
    paths = [
      # media
      beets
      sioyek
      obsidian

      # files
      sshfs-fuse
      spacedrive

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
  }

