{
  description = ''
    ░░░░░█░█░█░█░█░█░▀█▀░░░░
    ░░░░░░█░░█░█░█▀▄░░█░░░░░
    ░░░░░░▀░░▀▀▀░▀░▀░▀▀▀░░░░

    Rxyhn's NixOS configuration.
    Designed to provide a smooth and solid system experience.
  '';

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};

  inputs = {
    catppuccin-vsc.url = "github:catppuccin/vscode";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nh.url = "github:viperML/nh";
    nix-index-db.url = "github:Mic92/nix-index-database";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-db.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.inputs.flake-utils.follows = "flake-utils";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };
}
