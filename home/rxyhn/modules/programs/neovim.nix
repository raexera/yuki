{
  config,
  pkgs,
  lib,
  ...
}:
with pkgs; {
  home.packages = [
    clang # C/C++
    clang-tools
    lldb
    nil
    sumneko-lua-language-server
    stylua # Lua
    selene
    uncrustify
    shellcheck
    # Rust nightly
    (rust-bin.selectLatestNightlyWith
      (toolchain: toolchain.minimal))
    # rust-analyzer
    alejandra # Nix
    delve
    gopls # go
    go
    gopkgs
    go-outline
    go-tools
    gotests
    gomodifytags
    gocode-gomod
    gopls
    golangci-lint
    impl
    ktlint
    asmfmt
    ccls # cpp
    black # python
    shellcheck # bash
    shfmt
    nodejs
    nodePackages.pyright
    nodePackages.prettier
    nodePackages.stylelint
    nodePackages.jsonlint # JSON
    nodePackages.typescript-language-server # Typescript
    nodePackages.vscode-langservers-extracted # HTML, CSS, JavaScript
    nodePackages.yarn
    nodePackages.bash-language-server
    nodePackages.node2nix # Bash
    rnix-lsp
    texlab
  ];

  programs.neovim = {
    enable = true;
    package = neovim-nightly;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      lsp_lines-nvim
      lspkind-nvim
      nvim-lspconfig
      cmp_luasnip
      nvim-cmp
      cmp-nvim-lsp-signature-help
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      (nvim-treesitter.withPlugins (plugins:
        with plugins; [
          tree-sitter-python
          tree-sitter-c
          tree-sitter-nix
          tree-sitter-cpp
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-json
          tree-sitter-lua
          tree-sitter-go
          tree-sitter-java
          tree-sitter-typescript
          tree-sitter-javascript
          tree-sitter-cmake
          tree-sitter-comment
          tree-sitter-http
          tree-sitter-regex
          tree-sitter-dart
          tree-sitter-make
          tree-sitter-html
          tree-sitter-css
          tree-sitter-latex
          tree-sitter-bibtex
          tree-sitter-php
          tree-sitter-sql
          tree-sitter-zig
          tree-sitter-dockerfile
        ]))
    ];
  };

  home.file = {
    "nyoom.nvim" = {
      source = nyoomNvim-src;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
