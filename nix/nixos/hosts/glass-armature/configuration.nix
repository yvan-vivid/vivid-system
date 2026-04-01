# Yvan Vivid - 'glass-armature' NixOS config
let
  gttLimitGB = 112;
  gibToMib = gib: gib * 1024;
  gibToPages = gib: gib * 262144;
in
  {
    pkgs,
    inputs,
    ...
  }: {
    imports = with inputs.nixos-hardware.nixosModules; [
      ./hardware-configuration.nix
      framework-desktop-amd-ai-max-300-series
      common-hidpi
    ];

    boot.kernelPackages = pkgs.linuxPackages_6_19;

    boot.kernelParams = [
      "iommu=pt"
      "amdgpu.gttsize=${toString (gibToMib gttLimitGB)}"
      "ttm.pages_limit=${toString (gibToPages gttLimitGB)}"
    ];

    services = {
      fwupd.enable = true;
    };

    yvan = {
      name = "glass-armature";
      primary = "hexxiiiz";

      machine = {
        server.enable = true;
        desktop.enable = true;
      };
      dev.full = true;

      services = {
        docker.enable = true;
        ssh.enable = true;
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
