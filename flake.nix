{
  description = "Rxyhn's NixOS Configuration with Home-Manager & Flake";

  outputs = {nixpkgs, ...} @ inputs:
    with nixpkgs.lib; let
      system = "x86_64-linux";

      lib = import ./lib inputs;
      overlays.default = import ./overlays;

      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowBroken = true;
          allowUnfree = true;
          tarball-ttl = 0;
        };
        overlays = with inputs; [
          (
            final: _: let
              inherit (final) system;
            in
              (with nixpkgs-f2k.packages.${system}; {
                # Overlays with f2k's repo
                awesome = awesome-git;
                picom = picom-git;
                wezterm = wezterm-git;
              })
              // {
                # Non Flakes
                fzf-tab-src = fzf-tab;
              }
          )
          nur.overlay
          nixpkgs-wayland.overlay
          nixpkgs-f2k.overlays.default
          rust-overlay.overlays.default
          overlays.default
        ];
      };
    in {
      inherit lib pkgs overlays;

      # standalone home-manager config
      inherit (import ./home/profiles inputs) homeConfigurations;

      # nixos-configs with home-manager
      nixosConfigurations = import ./hosts inputs;

      # dev shell (for direnv)
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          rnix-lsp
          yaml-language-server
          alejandra
          git
        ];
        name = "dotfiles";
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flakes
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    ragenix.url = "github:yaxitech/ragenix";
    nur.url = "github:nix-community/NUR";
    devshell.url = "github:numtide/devshell";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";

    # Non flakes
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
  };
}
