{
  description = "Yvan Vivid's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-edge.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: let
    inherit (inputs.self) overlays;
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem;
    inherit (builtins) attrNames readDir listToAttrs;
    system = "x86_64-linux";
    overlayParams = {inherit inputs system;};
    overlaysToApply = [overlays.version-refs];
    overlayMod = {nixpkgs.overlays = overlaysToApply;};
    commonModules = [./modules overlayMod];
    hostDirs = attrNames (readDir ./hosts);
    buildHost = host:
      nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [./hosts/${host}/configuration.nix] ++ commonModules;
      };
    buildHostKV = host: {
      name = host;
      value = buildHost host;
    };
  in {
    overlays = import ./overlays overlayParams;
    nixosConfigurations = listToAttrs (map buildHostKV hostDirs);
  };
}
