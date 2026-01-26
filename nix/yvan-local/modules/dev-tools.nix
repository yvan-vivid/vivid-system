{pkgs}:
with pkgs;
  buildEnv {
    name = "yvan-dev-tools";
    paths = [
      pandoc
      hexyl
      marp-cli
      # qmk

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
      taplo
      ruff
      ty

      # compilers / interpreters
      tree-sitter
      go
      gcc

      # code management
      tokei
      gfold

      # language servers
      bash-language-server
      vscode-langservers-extracted
      typescript-language-server
      svelte-language-server
      yaml-language-server
      lua-language-server
      marksman
      texlab
      nixd
    ];
  }

