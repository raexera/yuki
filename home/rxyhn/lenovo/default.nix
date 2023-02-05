{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../shared

    ./desktop
    ./services
    ./X
    ./packages.nix
  ];
}
