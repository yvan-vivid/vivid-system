{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.yvan-dev-tools = pkgs.buildEnv {
      name = "yvan-dev-tools";
      paths = with pkgs; [
        # python
        uv
        ty
        ruff

        # lua
        luarocks
        stylua

        # documentation
        pandoc
        hexyl
        marp-cli
        # qmk

        # rust
        rustup
        cargo-info
        rusty-man

        # linters / formatters
        prettierd
        languagetool
        shellcheck
        shfmt
        html-tidy
        alejandra
        harper
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
        vscode-langservers-extracted
        typescript-language-server
        svelte-language-server
        yaml-language-server
        lua-language-server
        marksman
        nixd

        # AI/ML development
        inputs.opencode.packages."${pkgs.system}".default
      ];
    };
  };
}
