{pkgs, ...}: {
  programs = {
    zsh.enable = true;
    fish.enable = true;
    tmux.enable = true;
    direnv.enable = true;
    git.enable = true;
  };
  environment.systemPackages = with pkgs; [
    sheldon
    tmuxp
    fzf
    starship
  ];
}
