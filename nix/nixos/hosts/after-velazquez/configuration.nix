# Yvan Vivid - 'after-velazquez' NixOS config
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  # this machine easily gets torched
  powerManagement.cpuFreqGovernor = "conservative";
  boot.kernelParams = [
    "amd_pstate_epp=power"
  ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

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

    machine.server.enable = true;
    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
      media-server.enable = true;
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
