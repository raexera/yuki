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

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.default
      inputs.nixpkgs-f2k.overlays.stdenvs
      inputs.nur.overlay

      (final: prev: (with inputs.nixpkgs-f2k.packages.${pkgs.system}; {
        inherit phocus; # suggest consuming this as inputs.nixpkgs-f2k.packages.${pkgs.system}.phocus;
      }))
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
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
