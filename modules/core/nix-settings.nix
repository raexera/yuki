{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.defaultPackages = [];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # faster rebuilding
  documentation = {
    enable = false;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 4d";
    };

    package = pkgs.nixUnstable;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      allowed-users = ["rxyhn"];
      auto-optimise-store = true;
      max-jobs = "auto";
      sandbox = false;

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org?priority=5"
        "https://fortuneteller2k.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://hyprland.cachix.org"
        "https://webcord.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "webcord.cachix.org-1:l555jqOZGHd2C9+vS8ccdh8FhqnGe8L78QrHNn+EFEs="
      ];
    };
  };
  system.autoUpgrade.enable = false;
  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
