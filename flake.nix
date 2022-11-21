{
  description = "Rxyhn's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    ragenix.url = "github:yaxitech/ragenix";
    hyprland.url = "github:hyprwm/Hyprland/";
    nur.url = "github:nix-community/NUR";
    webcord.url = "github:fufexan/webcord-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Non flakes
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };

    zsh-completions = {
      url = "github:zsh-users/zsh-completions";
      flake = false;
    };

    zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };
  };
  outputs = {nixpkgs, ...} @ inputs: let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
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

    overlays.default = import ./pkgs;

    packages.x86_64-linux = import ./pkgs null pkgs;
  };
}
