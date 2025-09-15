# Yvan Vivid - NixOS Flake
# Based on some inspirations:
#   `Misterio77/nix-starter-configs`
#   `Andrey0189/nixos-config`
#   and other resources
{
  description = "Yvan Vivid's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-edge.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: let
    inherit (inputs.self) overlays;
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem;
    system = "x86_64-linux";
    overlayParams = {inherit inputs system;};
    overlaysToApply = [overlays.version-refs];
    overlayMod = {nixpkgs.overlays = overlaysToApply;};
    commonModules = [./modules overlayMod];
  in {
    overlays = import ./overlays overlayParams;

    # Your custom packages
    # packages = import ./pkgs inputs.nixos.legacyPackages.${system};

    # Formatter for your nix files, available through 'nix fmt'
    # formatter = edge.legacyPackages.${system}.alejandra;

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;

    nixosConfigurations = {
      red-arrow = nixosSystem {
        modules = [./hosts/red-arrow/configuration.nix] ++ commonModules;
      };
      after-velazquez = nixosSystem {
        modules = [./hosts/after-velazquez/configuration.nix] ++ commonModules;
      };
    };
  };
}
