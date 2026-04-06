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

      imports =
        let
          dir = ./modules;
          files = builtins.readDir dir;
          nixFiles = builtins.filter (name: builtins.match ".*\\.nix$" name != null) (builtins.attrNames files);
        in
        map (name: dir + "/${name}") nixFiles;

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        packages.yvan-local = pkgs.buildEnv {
          name = "yvan-local";
          paths = with config.packages; [
            yvan-python-env
            yvan-production
            yvan-dev-tools
            yvan-term-env
            yvan-apps
          ];
        };

        packages.default = config.packages.yvan-local;
      };
    };
}
