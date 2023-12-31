{
  imports = [
    ../../modules/programs/firefox.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/media.nix
    ../../modules/programs/packages.nix
    ../../modules/programs/tools.nix
    ../../modules/programs/vscode.nix

    ../../modules/services/kdeconnect.nix
    ../../modules/services/syncthing.nix

    ../../modules/windowManager/hyprland
  ];
}
