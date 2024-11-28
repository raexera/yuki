{
  config,
  pkgs,
  ...
}: {
  programs.go = rec {
    enable = true;
    goPath = ".go";
    goBin = "${goPath}/bin";
  };

  home = {
    packages = with pkgs; [
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

    sessionPath = ["${config.home.homeDirectory}/${config.programs.go.goBin}"];
  };
}
