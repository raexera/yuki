{
  description = "Rxyhn's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nixpkgs-wayland, ... }@attrs: 
    let
      system = "x86_64-linux";
      overlays = [ ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config = {
          allowUnfree = true; # for nvidia, gitkraken, discord, etc
        };
      };
      lib = nixpkgs.lib;
    in {
    nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        ./hosts/NixOS/configuration.nix
        ./modules/nvidia
        home-manager.nixosModules.home-manager
        ({
            home-manager.useGlobalPkgs = true;
            home-manager.users.rxyhn = lib.mkMerge [
              ./users/rxyhn/home.nix
            ];
        })
      ];
    };
  };
}