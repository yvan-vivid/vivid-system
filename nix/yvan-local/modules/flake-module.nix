{
  perSystem = {pkgs, ...}: {
    packages = let
      python-env = import ./python-env.nix {inherit pkgs;};
      node-env = import ./node-env.nix {inherit pkgs;};
      production = import ./production.nix {inherit pkgs;};
      dev-tools = import ./dev-tools.nix {inherit pkgs;};
      term-env = import ./term-env.nix {inherit pkgs;};
      apps = import ./apps.nix {inherit pkgs;};
    in {
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
}