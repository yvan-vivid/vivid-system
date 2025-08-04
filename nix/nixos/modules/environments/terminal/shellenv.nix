{pkgs, ...}: {
  programs = {
    zsh.enable = true;
    fish.enable = true;
    tmux.enable = true;
    direnv.enable = true;
    git.enable = true;
    zoxide.enable = true;
  };
  environment.systemPackages = with pkgs; [
    sheldon
    fzf
    sesh
    oh-my-posh
    keychain
  ];
}
