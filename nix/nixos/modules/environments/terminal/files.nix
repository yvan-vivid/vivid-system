{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # File inspection
    file
    bat
    less
    mime-types
    jq
    fx
    glow

    # Directory listing and search
    eza
    lsd
    tree
    fd
    findutils
    ncdu
    yazi
    ueberzugpp
    duff

    # File utilities
    ripgrep
    zip
    unzip
    rclone

    # Editing
    neovim
  ];
}
