{
  flake = {
    nixosModules = {};

    homeManagerModules = {
      swaync = import ./home-manager/swaync.nix;

      shell = {
        imports = [
          ./home-manager/programs/git.nix
          ./home-manager/programs/gpg.nix
          ./home-manager/programs/starship.nix
          ./home-manager/programs/utils.nix
          ./home-manager/programs/zsh.nix

          ./home-manager/programs/scripts/preview.nix
          ./home-manager/programs/scripts/run-as-service.nix
        ];
      };
    };
  };
}
