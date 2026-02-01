{
  description = "Yvan's Nix Environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    opencode.url = "github:anomalyco/opencode";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        ./modules/python-env.nix
        ./modules/node-env.nix
        ./modules/production.nix
        ./modules/dev-tools.nix
        ./modules/term-env.nix
        ./modules/apps.nix
        ./modules/combined.nix
      ];

      perSystem = {
        config,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        packages.default = config.packages.yvan-local;
      };
    };
}
