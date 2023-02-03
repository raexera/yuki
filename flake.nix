{
  description = "Rxyhn's NixOS Configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    helix.url = "github:helix-editor/helix";
    nur.url = "github:nix-community/NUR";
    webcord.url = "github:fufexan/webcord-flake";

    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs.follows = "nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-f2k.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachPkgs (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      # Laptop
      lenovo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/lenovo];
      };
    };

    homeConfigurations = {
      # Laptop
      "rxyhn@lenovo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/rxyhn/lenovo.nix];
      };
    };
  };
}
