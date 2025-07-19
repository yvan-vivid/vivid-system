{pkgs, ...}: {
  programs = {
    # File inspection
    bat.enable = true;
    less.enable = true;

    # Directory listing and search
    yazi.enable = true;

    # Editing
    neovim.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # File inspection
    file
    mime-types
    jq
    glow

    # Directory listing and search
    eza
    fd
    findutils
    ncdu
    ueberzugpp

    # File utilities
    ripgrep
    zip
    unzip
  ];
}
