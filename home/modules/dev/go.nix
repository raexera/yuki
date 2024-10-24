{pkgs, ...}: {
  home.packages = with pkgs; [
    gofumpt
    goimports-reviser
    golangci-lint
    golines
    gomodifytags
    gopls
    gotests
    go-tools # staticcheck
    gotools # goimports
    delve
    impl
    revive
  ];

  programs.go = {
    enable = true;
    goPath = ".go";
    goBin = ".local/bin";
  };
}
