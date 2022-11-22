{inputs, ...}: {
  imports = [
    ./packages.nix

    ../../gtk

    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/firefox.nix
    ../../programs/mpd.nix
  ];
}
