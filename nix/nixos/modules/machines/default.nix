{pkgs, ...}: {
  imports = [
    ./laptop.nix
    ./server.nix
  ];

  config = {
    # Bluetooth
    hardware.bluetooth.enable = true;

    # Thunderbolt
    # TODO: If thunderbolt
    # services.hardware.bolt.enable = true;

    # Power / thermal
    services = {
      thermald.enable = true;
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

    programs.gnupg = {
      agent.enable = true;
    };

    environment.systemPackages = with pkgs; [
      f2fs-tools
      udisks
      bluetuith
    ];
  };
}
