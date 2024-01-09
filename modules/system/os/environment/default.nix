{...}: {
  imports = [
    ./locale.nix
  ];

  environment = {
    pathsToLink = ["/share/zsh"];
  };
}
