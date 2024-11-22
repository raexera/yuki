{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.lix;

    # Pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
      lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # Set the path for channels compat
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

  # We need git for flakes
  environment.systemPackages = [pkgs.git];
}
