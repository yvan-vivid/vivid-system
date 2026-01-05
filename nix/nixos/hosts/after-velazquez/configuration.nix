# Yvan Vivid - 'after-velazquez' NixOS config
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

    allowedTCPPorts = [80 443 8096 8020 53];
    allowedUDPPorts = [7359 53 50873];
  };

  # this machine easily gets torched
  powerManagement.cpuFreqGovernor = "conservative";
  boot.kernelParams = [
    "amd_pstate_epp=power"
  ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

  environment.systemPackages = [
    pkgs.nginx
  ];

  services = {
    # `thermald` only works for intel
    thermald.enable = false;
    resolved.extraConfig = ''
      DNSStubListener=no
    '';
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
