{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./nix-settings.nix
    ./users.nix
  ];
}
