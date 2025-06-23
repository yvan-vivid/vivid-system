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

    python-packages = py:
      with py; [
        mypy
        pynvim
        pylint
        pytest
        ipython
        pylatexenc
      ];

    python-with-packages = pkgs: ((pkgs.python312.withPackages python-packages).override {
      ignoreCollisions = true;
    });

    node-packages = pkgs:
      with pkgs.nodePackages; [
        pkgs.nodejs
        eslint
        typescript
        prettier
      ];

    tex-setup = pkgs:
      pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-basic titlesec xetex collection-latexextra;
      };
  in {
    packages = forEachSystem ({pkgs}:
      with pkgs; rec {
        yvan-python-env = buildEnv {
          name = "yvan-python-env";
          paths = [
            (python-with-packages pkgs)
            poetry
          ];
        };

        yvan-node-env = buildEnv {
          name = "yvan-node-env";
          paths = node-packages pkgs;
        };

        yvan-production = buildEnv {
          name = "yvan-production";
          paths = [
            audacity
            ardour
            mediainfo
            cheese
            fluidsynth
            soundfont-fluid
            lame
            # zrythm
            gimp
            shotwell
            imagemagick
            inkscape
            blender
            darktable
            olive-editor
            obs-studio
          ];
        };

        yvan-dev-tools = buildEnv {
          name = "yvan-dev-tools";
          paths = [
            niv
            shellcheck
            pandoc
            hexyl
            socat
            gita
            tree-sitter
            gcc
            luarocks
            rustup
            qmk
            go
            uv
            bash-language-server
            typescript-language-server
            svelte-language-server
            yaml-language-server
            lua-language-server
            marksman
            nixd
            prettierd
            basedpyright
            harper
            shfmt
            html-tidy
            alejandra
            stylua
            csslint
            ruff
            texlab
            pdftk
            languagetool
            (tex-setup pkgs)
          ];
        };

        yvan-term-env = buildEnv {
          name = "yvan-term-env";
          paths = [
            neovim
            helix
            traceroute
            btop
            bottom
            fx
            glow
            ueberzugpp
            zoxide
            systemctl-tui
            aerc
            dysk
            oh-my-posh
            fish
            sesh
            yazi
            eza
            rclone
            duff
          ];
        };

        yvan-apps = buildEnv {
          name = "yvan-apps";
          paths = [
            beets
            sioyek
            yt-dlp
            sshfs-fuse
            spacedrive
            firefox-bin
            chromium
            foot
            signal-desktop
            discord
            tdesktop
            zoom-us
            wireguard-tools
            obsidian
            gzdoom
            higan
            zsnes
            ollama
          ];
        };

        yvan-local = buildEnv {
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
