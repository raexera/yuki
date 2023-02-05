{
  lib,
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports =
    [
      inputs.nix-colors.homeManagerModule
      inputs.webcord.homeManagerModules.default

      ./programs
      ./shell
      ./packages.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.nixpkgs-f2k.overlays.stdenvs
      inputs.nur.overlay

      (final: prev: (with inputs.nixpkgs-f2k.packages.${pkgs.system}; {
        inherit phocus;
        picom = picom-git;
        wezterm = wezterm-git;
      }))
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  home = {
    username = lib.mkDefault "rxyhn";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
  };

  colorscheme = lib.mkDefault colorSchemes.ashes;
  home.file.".colorscheme".text = config.colorscheme.slug;
}
