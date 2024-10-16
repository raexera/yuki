{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./devops.nix
    ./go.nix
    ./python.nix
  ];

  home = {
    packages = lib.attrValues {
      # Dev Tools
      inherit
        (pkgs)
        bun
        ccls
        clang
        clang-tools
        cmake
        grex
        java-language-server
        just
        lldb
        nodejs
        shellcheck
        shfmt
        typescript
        uncrustify
        ;

      inherit
        (pkgs.nodePackages)
        jsonlint
        pnpm
        prettier
        typescript-language-server
        vls
        vscode-langservers-extracted
        yaml-language-server
        yarn
        ;
    };
  };
}
