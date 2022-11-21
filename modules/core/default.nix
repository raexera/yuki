{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./network.nix
    ./nix-settings.nix
    ./users.nix
  ];
}
