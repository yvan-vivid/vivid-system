# Yvan Vivid - 'glass-armature' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 13000;
        to = 13999;
      }
    ];
  };

  # boot.kernelParams = [];

  services = {
    # `thermald` only works for intel
    thermald.enable = false;
  };

  yvan = {
    name = "glass-armature";
    primary = "hexxiiiz";

    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
    };

    environments = {
      runtime.enable = true;
      graphical = {
        sway.enable = true;
        apps.enable = true;
      };
    };
  };
}
