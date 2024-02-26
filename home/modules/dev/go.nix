{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      delve
      go
      go-tools # staticcheck
      gofumpt
      golangci-lint
      gomodifytags
      gopls
      gotests
      gotools # goimports
      impl
      revive
    ];

    sessionVariables = rec {
      GOPATH = "${config.xdg.dataHome}/go";
      GOBIN = "${GOPATH}/bin";
    };
  };
}
