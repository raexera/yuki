{
  flake.homeManagerModules = {
    hyprland = {
      imports = [
        ./services/swaync.nix
        ./wayland/windowManager/hyprland
      ];
    };

    misc = {
      gtk = import ./misc/gtk.nix;
      home-cursor = import ./misc/home-cursor.nix;
    };

    shell = {
      imports = [
        ./programs/git.nix
        ./programs/gpg.nix
        ./programs/starship.nix
        ./programs/utils.nix
        ./programs/zsh.nix

        ./programs/scripts/preview.nix
        ./programs/scripts/run-as-service.nix
      ];
    };
  };
}
