{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  nix = {
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";
      keep-derivations = true;
      keep-outputs = true;
      trusted-users = ["root" "@wheel"];
    };
  };

  system.stateVersion = lib.mkDefault "23.11";
}
