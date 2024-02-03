# {self, ...}: let
#   mkFlakeModule = path:
#     if builtins.isPath path
#     then self + path
#     else self + (import path);
#in
{
  flake = {
    nixosModules = {};

    homeManagerModules = {
      swaync = import ./home-manager/services/swaync.nix;

      hyprland = {
        imports = [
          ./home-manager/wayland/windowManager/hyprland
        ];
      };

      misc = {
        gtk = import ./home-manager/misc/gtk.nix;
        home-cursor = import ./home-manager/misc/home-cursor.nix;
      };

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
