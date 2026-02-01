{pkgs, ...}: {
  imports = [
    ./desktop.nix
    ./laptop.nix
    ./server.nix
  ];

  config = {
    # Enable firmware regardless of license
    hardware.enableAllFirmware = true;

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Power / thermal
    services = {
      upower.enable = true;
    };

    # Other services
    services = {
      irqbalance.enable = true;
    };

    # Security
    security = {
      sudo.enable = true;
      polkit.enable = true;
    };

    programs.gnupg.agent = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      f2fs-tools
      udisks
      bluetuith

      # Security
      pass
      pinentry-tty
    ];
  };
}
