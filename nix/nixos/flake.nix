{
  description = "Yvan Vivid's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-edge.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem;
    inherit (builtins) attrNames readDir listToAttrs;
    system = "x86_64-linux";
    pkgs-edge = import inputs.nixpkgs-edge {
      inherit system;
      config.allowUnfree = true;
    };
    commonModules = [./modules];
    hostDirs = attrNames (readDir ./hosts);
    buildHost = host:
      nixosSystem {
        inherit system;
        specialArgs = {inherit inputs pkgs-edge;};
        modules = [./hosts/${host}/configuration.nix] ++ commonModules;
      };
    buildHostKV = host: {
      name = host;
      value = buildHost host;
    };
  in {
    nixosConfigurations = listToAttrs (map buildHostKV hostDirs);
  };
}
