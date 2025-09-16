# Yvan Vivid - 'after-velazquez' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_12;

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 13000;
        to = 13999;
      }
    ];

    allowedTCPPorts = [8096 8020];
    allowedUDPPorts = [7359];
  };

  # this machine easily gets torched
  powerManagement.cpuFreqGovernor = "conservative";
  boot.kernelParams = [
    "amd_pstate_epp=power"
  ];

  services = {
    # `thermald` only works for intel
    thermald.enable = false;
  };

  yvan = {
    name = "after-velazquez";
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
