{pkgs}: let
  node-packages = pkgs:
    with pkgs.nodePackages; [
      pkgs.nodejs
      eslint
      typescript
      prettier
    ];
in
  pkgs.buildEnv {
    name = "yvan-node-env";
    paths = node-packages pkgs;
  }

