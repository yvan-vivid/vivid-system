# Yvan Vivid - 'after-velazquez' NixOS config
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-hidpi
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

    machine.server.enable = true;
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
