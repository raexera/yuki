{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      go
      gofumpt
      golangci-lint
      gomodifytags
      gopls
      gotests
      go-tools # staticcheck
      gotools # goimports
      delve
      impl
      revive
    ];

    sessionVariables = rec {
      GOPATH = "${config.xdg.dataHome}/go";
      GOBIN = "${GOPATH}/bin";
    };
  };
}
