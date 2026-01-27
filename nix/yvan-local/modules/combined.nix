{...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages.yvan-local = pkgs.buildEnv {
      name = "yvan-local";
      paths = with config.packages; [
        yvan-python-env
        yvan-node-env
        yvan-production
        yvan-dev-tools
        yvan-term-env
        yvan-apps
      ];
    };
  };
}
