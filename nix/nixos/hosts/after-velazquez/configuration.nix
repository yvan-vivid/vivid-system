# Yvan Vivid - 'after-velazquez' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    ./hardware-configuration.nix
    common-cpu-amd
    common-gpu-amd
    common-pc
    common-pc-ssd
    common-hidpi
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_18;

  boot.kernelParams = [
    "amd_pstate_epp=power"
  ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;

  services = {
    resolved.extraConfig = ''
      DNSStubListener=no
    '';
  };

  yvan = {
    name = "after-velazquez";
    primary = "hexxiiiz";

    machine = {
      server.enable = true;
      desktop.enable = true;
    };
    dev.full = true;

    services = {
      docker.enable = true;
      ssh.enable = true;
      media-server.enable = true;
    };

    media = {
      rocm.enable = true;
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
