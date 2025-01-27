{config, ...}: {
  nix.settings = {
    experimental-features = "nix-command flakes";

    # Workaround for https://github.com/NixOS/nix/issues/9574
    nix-path = config.nix.nixPath;
  };

  # Nix setup
  nixpkgs.config.allowUnfree = true;

  # Localization
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Config format version (not release version)
  system.stateVersion = "22.11";
}
