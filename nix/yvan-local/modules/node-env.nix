{...}: {
  perSystem = {pkgs, ...}: {
    packages.yvan-node-env = pkgs.buildEnv {
      name = "yvan-node-env";
      paths = with pkgs; [
        nodejs
        pkgs.nodePackages.eslint
        nodePackages.typescript
        nodePackages.prettier
      ];
    };
  };
}
