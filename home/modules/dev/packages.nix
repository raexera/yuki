{pkgs, ...}: {
  home.packages = with pkgs; [
    beekeeper-studio
    bun
    ccls
    clang
    clang-tools
    cmake
    dbmate
    gnumake
    grex
    java-language-server
    just
    lldb
    nodejs
    pm2
    pnpm
    pocketbase
    podman-compose
    postman
    prettierd
    redis
    scc
    sea-orm-cli
    shellcheck
    shfmt
    slack
    turso-cli
    typescript
    uncrustify
  ];
}
