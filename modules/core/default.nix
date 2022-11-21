{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./network.nix
    ./nix.nix
    ./users.nix
  ];
}
