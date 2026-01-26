{pkgs}: let
  python-packages = py:
    with py; [
      pynvim
      pytest
      ipython
    ];

  python-with-packages = pkgs: ((pkgs.python313.withPackages python-packages).override {
    ignoreCollisions = true;
  });
in
  pkgs.buildEnv {
    name = "yvan-python-env";
    paths = [
      (python-with-packages pkgs)
    ];
  }

