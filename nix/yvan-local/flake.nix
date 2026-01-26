{
  description = "Yvan's Nix Environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    # Supported systems
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };
          };
        });

    # Import environment modules
    python-env = import ./modules/python-env.nix;
    node-env = import ./modules/node-env.nix;
    production = import ./modules/production.nix;
    dev-tools = import ./modules/dev-tools.nix;
    term-env = import ./modules/term-env.nix;
    apps = import ./modules/apps.nix;
  in {
    packages = forEachSystem ({pkgs}: rec {
      yvan-python-env = python-env { inherit pkgs; };
      yvan-node-env = node-env { inherit pkgs; };
      yvan-production = production { inherit pkgs; };
      yvan-dev-tools = dev-tools { inherit pkgs; };
      yvan-term-env = term-env { inherit pkgs; };
      yvan-apps = apps { inherit pkgs; };

      yvan-local = pkgs.buildEnv {
        name = "yvan-local";
        paths = [
          yvan-python-env
          yvan-node-env
          yvan-production
          yvan-dev-tools
          yvan-term-env
          yvan-apps
        ];
      };

      default = yvan-local;
    });
  };
}
