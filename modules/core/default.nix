{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system
    ./network
    ./fonts
    ./nix.nix
  ];
}
