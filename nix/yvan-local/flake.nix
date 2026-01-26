{
  description = "Yvan's Nix Environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {system, ...}: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        python-env = import ./modules/python-env.nix {inherit pkgs;};
        node-env = import ./modules/node-env.nix {inherit pkgs;};
        production = import ./modules/production.nix {inherit pkgs;};
        dev-tools = import ./modules/dev-tools.nix {inherit pkgs;};
        term-env = import ./modules/term-env.nix {inherit pkgs;};
        apps = import ./modules/apps.nix {inherit pkgs;};
      in {
        packages = {
          yvan-python-env = python-env;
          yvan-node-env = node-env;
          yvan-production = production;
          yvan-dev-tools = dev-tools;
          yvan-term-env = term-env;
          yvan-apps = apps;
          yvan-local = pkgs.buildEnv {
            name = "yvan-local";
            paths = [
              python-env
              node-env
              production
              dev-tools
              term-env
              apps
            ];
          };

          default = python-env;
        };
      };
    };
}
