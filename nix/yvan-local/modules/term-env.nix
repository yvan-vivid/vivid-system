{...}: {
  perSystem = {pkgs, ...}: {
    packages.yvan-term-env = pkgs.buildEnv {
      name = "yvan-term-env";
      paths = with pkgs; [
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
        fastfetch
        inxi

        # file transfer
        rclone

        # network
        socat
        traceroute
        xh
        tcpdump
        speedtest-go
        openssl
        nftables

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
        lazygit
        lazydocker
        radeontop
        qrencode
        oxker

        # email
        aerc
        nomacs

        # nix
        nvd
        nix-diff

        # utilities
        ueberzugpp
        bc
        nh

        # media
        ffmpeg
        poppler
      ];
    };
  };
}
