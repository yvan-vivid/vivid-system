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
            # audio
            audacity
            ardour
            mediainfo
            lame
            # zrythm

            # image
            # gimp
            shotwell
            imagemagick
            inkscape
            # darktable

            # video
            olive-editor
            obs-studio

            # multimedia
            blender
          ];
        };

        yvan-dev-tools = buildEnv {
          name = "yvan-dev-tools";
          paths = [
            pandoc
            hexyl
            marp-cli
            # qmk
            (tex-setup pkgs)

            # package/language managers
            uv
            luarocks
            rustup

            # rust
            cargo-info
            rusty-man

            # linters / formatters
            prettierd
            languagetool
            shellcheck
            shfmt
            html-tidy
            alejandra
            stylua
            ruff
            harper
            csslint
            taplo

            # compilers / interpreters
            tree-sitter
            go
            gcc

            # code management
            tokei
            gfold

            # language servers
            bash-language-server
            typescript-language-server
            svelte-language-server
            yaml-language-server
            lua-language-server
            marksman
            texlab
            nixd
            basedpyright
          ];
        };

        yvan-term-env = buildEnv {
          name = "yvan-term-env";
          paths = [
            # shell env
            fish
            oh-my-posh
            sesh
            zoxide

            # file info
            eza
            yazi

            # deduplication
            duff

            # file size
            dua
            du-dust

            # disk usage
            dysk
            duf

            # system info
            neofetch
            inxi

            # file transfer
            rclone

            # network
            socat
            traceroute
            xh

            # file tools
            ansifilter
            qpdf

            # choosing
            gum

            # reading/editing
            neovim
            helix
            fx
            glow

            # tui apps
            bottom
            btop
            systemctl-tui
            gitui

            # email
            aerc
            nomacs

            # utilities
            ueberzugpp
            bc
            nh
          ];
        };

        yvan-apps = buildEnv {
          name = "yvan-apps";
          paths = [
            # media
            beets
            sioyek
            obsidian

            # files
            sshfs-fuse
            spacedrive

            # ai
            ollama

            # networking
            wireguard-tools
            yt-dlp
            gallery-dl

            # social networking
            # zoom-us
            signal-desktop
            discord
            tdesktop

            # browsers
            firefox-bin
            chromium

            # emulation
            gzdoom
            higan
            zsnes
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
