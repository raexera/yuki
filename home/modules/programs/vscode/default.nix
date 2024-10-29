{pkgs, ...}: {
  imports = [
    ./extensions.nix
    ./keybindings.nix
    ./usersettings.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };
}
