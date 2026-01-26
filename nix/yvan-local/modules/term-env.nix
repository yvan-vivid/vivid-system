{pkgs}:
with pkgs;
  buildEnv {
    name = "yvan-term-env";
    paths = [
      # shell env
      fish
      oh-my-posh
      sesh
      zoxide

      # file info
      eza
      yazi

      # deduplication
      duff

      # file size
      dua
      dust

      # disk usage
      dysk
      duf

      # system info
      neofetch
      inxi

      # file transfer
      rclone

      # network
      socat
      traceroute
      xh

      # file tools
      ansifilter
      qpdf

      # choosing
      gum

      # reading/editing
      neovim
      helix
      fx
      glow

      # tui apps
      bottom
      btop
      systemctl-tui
      gitui

      # email
      aerc
      nomacs

      # utilities
      ueberzugpp
      bc
      nh

      # media
      ffmpeg
      poppler
    ];
  }
